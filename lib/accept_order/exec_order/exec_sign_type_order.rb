# coding: utf-8

module ExecOrder
    class ExecSignTypeOrder
    
        def execute(target_identifier)
            # ループの終了条件を満たすまで繰り返す
            while true do
                puts "ExecSignTypeOrder execute start"
            
                # 処理するオーダーを特定する
                target_order = select_target_order(target_identifier)
            
                # 処理するオーダーがなければ、ループを抜ける
                break if target_order.blank?
                
                # 処理中のオーダーを拾った場合、それは前回の処理プロセスが途中で死んだことを意味する。
                # 異常終了扱いに更新する。
                if target_order.progress_status == Order::PROGRESS_STATUS_PROCESSING
                    change_progress_status_to_failed(target_order)
                    next
                end
            
                # オーダーを処理する
                execute_order(target_order)
            end
        end
    
        private
    
        # 処理対象とするオーダーを取得する
        def select_target_order(target_identifier)
            Order.where(target_type: Order::TARGET_TYPE_SIGN, 
                        progress_status: [Order::PROGRESS_STATUS_WAITING, Order::PROGRESS_STATUS_PROCESSING], 
                        target_identifier: target_identifier)
                        .order(id: :asc).first
        end
        
        # オーダーを処理する
        def execute_order(target_order)
            case target_order.section
            when Order::SECTION_SIGNIN
                SignTypeOrderExecutor::SigninSectionOrderExecutor.new(target_order).execute()
#            when "signout"
#                SignTypeOrderExecutor::SignoutSectionOrderExecutor.new(target_order).execute()
            else
                raise StandardError
            end
        end
        
        # オーダーを異常終了とする
        # params
        #   [Order] target_order 対象オーダー
        def change_progress_status_to_failed(target_order)
            begin
                target_order.progress_status = Order::PROGRESS_STATUS_FAILED
                target_order.save!
            rescue => err
                puts "FATAL: change_progress_status_to_failed"
            end
        end
    end
end