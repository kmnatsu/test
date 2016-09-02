module Application
    class OrderUntilOutwarkingWatcher
        
        # params
        #   [String] order_identifier オーダーの識別子
        def initialize(order_identifier)
            @target_order_identifier = order_identifier
        end

        # return
        #   [Order] 正常に完遂したオーダー
        def execute()
            # 指定したオーダーが完了するまで待機
            exec_end_order = wait_until_exec_end()
            
            # オーダーが正常終了しているかを確認
            check_order_finished(exec_end_order)
            
            # オーダーが完遂しているかを確認
            check_order_outwarking(exec_end_order)
            
            exec_end_order
        end
        
        private
        
        # 指定したオーダーが完了するまで待ち、取得する
        # return
        #   [Order] 処理が終了したオーダー
        def wait_until_exec_end()
            # 待ち時間が60秒に達するまで繰り返す
            start_unixtime = Time.now.to_i
            ActiveRecord::Base.uncached do
                while (Time.now.to_i - start_unixtime) < 60 do
                    target_order = Order.where(identifier: @target_order_identifier,
                                                progress_status: [Order::PROGRESS_STATUS_FINISHED, Order::PROGRESS_STATUS_FAILED, Order::PROGRESS_STATUS_CANCELED]).first
                    return target_order if target_order.present?
                    sleep 5
                end
            end
            raise Application::Exceptions::ErrCode003Error.new
        end
        
        # オーダーが正常終了しているかを確認
        # params
        #   [Order] target_order 確認対象オーダー
        def check_order_finished(target_order)
            # 正常終了していなかった場合、エラーを発生させる
            raise Application::Exceptions::ErrCode004Error.new unless target_order.progress_status == Order::PROGRESS_STATUS_FINISHED
        end
        
        # オーダーが完遂しているかを確認
        # params
        #   [Order] target_order 確認対象オーダー
        def check_order_outwarking(target_order)
            # 完遂していなかった場合、エラーを発生させる
            unless target_order.progress_result == Order::PROGRESS_RESULT_OUTWORKING
                if target_order.progress_result == Order::PROGRESS_RESULT_INTERRUPTION
                    case target_order.result_error_code
                    when Order::RESULT_ERROR_CODE_000
                        raise Application::Exceptions::ErrCode004Error.new
                    when Order::RESULT_ERROR_CODE_001
                        raise Application::Exceptions::ErrCode001Error.new
                    when Order::RESULT_ERROR_CODE_002
                        raise Application::Exceptions::ErrCode002Error.new
                    else
                        raise Application::Exceptions::ErrCode000Error.new
                    end
                else
                    raise Application::Exceptions::ErrCode000Error.new
                end
            end
        end
    end
end