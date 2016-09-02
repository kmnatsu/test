module ExecOrder
    module SignTypeOrderExecutor
        class SigninSectionOrderExecutor
            
            def initialize(target_order)
                @target_order = target_order
            end
            
            def execute()
                puts "SigninSectionOrderExecutor execute start"
                
                # 処理対象であるオーダーを「処理中」と永続化
                return unless change_progress_status_to_processing
                
                # オーダーとしての入力値をハッシュとして取得
                input_params = @target_order.get_parameter_hash
                
                # オーダーの処理対象となるアカウントを取得
                target_account = select_target_account
                
                # アカウントに対して認証実施可能かを確認
                return unless check_enable_authentication(target_account, input_params)
                
                # 未ログイン状態かを確認
                return unless check_unauthenticated(target_account)
                
                # 認証情報を生成
                create_sign(target_account)
            end
            
            private
            
            # 処理対象であるオーダーを「処理中」と永続化
            # return
            #   [Boolean] 成功したらtrue、失敗したらfalse
            def change_progress_status_to_processing()
                begin
                    @target_order.progress_status = Order::PROGRESS_STATUS_PROCESSING
                    @target_order.save!
                    return true
                rescue => err
                    puts "FATAL: change_progress_status_to_processing"
                    return false
                end
            end
            
            # オーダーの処理対象となるアカウントを取得
            # return
            #   [Account] 処理対象アカウント
            def select_target_account()
                Account.where(identifier: @target_order.target_identifier).first
            end
            
            # アカウントに対して認証実施可能かを確認
            # params
            #   [Account] target_account 認証対象アカウント
            #   [Hash] parameters 認証実施用パラメータ
            # return
            #   [Boolean] 認証可能ならばtrue、認証不可ならばfalse
            def check_enable_authentication(target_account, parameters)
                if target_account.password == parameters[:password]
                    return true
                else
                    begin
                        @target_order.progress_status = Order::PROGRESS_STATUS_FINISHED
                        @target_order.progress_result = Order::PROGRESS_RESULT_INTERRUPTION
                        @target_order.result_error_code = Order::RESULT_ERROR_CODE_001
                        @target_order.save!
                    rescue => err
                        puts "FATAL: check_enable_authentication"
                    ensure
                        return false
                    end
                end
            end
            
            # アカウントが未認証かを確認
            # params
            #   [Account] target_account 対象アカウント
            # return
            #   [Boolean] 未認証ならばtrue、認証済みならばfalse
            def check_unauthenticated(target_account)
                if target_account.sign.blank?
                    return true
                else
                    begin
                        @target_order.progress_status = Order::PROGRESS_STATUS_FINISHED
                        @target_order.progress_result = Order::PROGRESS_RESULT_INTERRUPTION
                        @target_order.result_error_code = Order::RESULT_ERROR_CODE_002
                        @target_order.save!
                    rescue => err
                        puts "FATAL: check_unauthenticated"
                    ensure
                        return false
                    end
                end
            end
            
            # 認証情報を生成
            # params
            #   [Account] target_account 対象アカウント
            def create_sign(target_account)

                # 認証情報及びトークンを生成
                new_sign = Sign.new
                new_token = Token.new({
                    key: SecureRandom.uuid
                })
                
                # オーダーのリザルト情報を生成
                order_result_detail = {
                    token: new_token.key,
                    account_id: target_account.identifier
                }.to_json
                
                # オーダーを更新
                @target_order.progress_status = Order::PROGRESS_STATUS_FINISHED
                @target_order.progress_result = Order::PROGRESS_RESULT_OUTWORKING
                @target_order.result_detail = order_result_detail
                
                # 処理内容の永続化
                begin
                    Account.transaction do
                        new_sign.tokens << new_token
                        target_account.sign = new_sign
                        @target_order.save!
                    end
                rescue => err
                    puts "FATAL: create_sign"
                ensure
                    return false
                end
            end
        end
    end
end