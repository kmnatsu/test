module Signs
    
    class CreateService
        
        def initialize(parameters)
            @account_id = parameters["account_id"]
            @password = parameters["password"]
        end
        
        # ログインを実行
        # return
        #   [Hash] 結果
        def execute()
            
            # 認証開始オーダーを登録可能なパラメータが揃っているかを確認
            check_input_parameters
            
            # 認証開始オーダーを登録
            order_identifier = make_order_sign_signin
            
            # 正常に完遂するまで待機し、取得する
            completed_order = Application::OrderUntilOutwarkingWatcher.new(order_identifier).execute
            
            # オーダーの結果を返却する
            completed_order.get_result_detail_hash
        end
        
        private
        
        # 認証開始オーダーを登録可能なパラメータが揃っているかを確認
        def check_input_parameters()
            # 指定されたアカウントIDに合致するアカウントが存在しない場合、認証エラーとする。
            raise Application::Exceptions::ErrCode001Error.new unless Account.where(identifier: @account_id).exists?
        end
        
        # 認証開始オーダーを登録
        # return
        #   [String] オーダーの識別子
        def make_order_sign_signin()
            # オーダーの識別子をランダム生成
            new_order_identifier = SecureRandom.uuid
            
            # オーダー用のパラメータを生成
            parameter_json = {
                password: @password
            }.to_json
            
            # オーダーを生成
            new_order = Order.new({
                identifier: new_order_identifier,
                target_type: Order::TARGET_TYPE_SIGN,
                section: Order::SECTION_SIGNIN,
                target_identifier: @account_id,
                progress_status: Order::PROGRESS_STATUS_WAITING,
                parameters: parameter_json
            })
            
            # オーダーを登録
            begin
                new_order.save!
            rescue => err
                puts "FATAL: make_order_sign_signin"
                raise Application::Exceptions::ErrCode000Error.new
            end
            
            new_order_identifier
        end
    end
end