class Api::SignsController < Api::Base

    # ログインAPI
    def create
        
        # リクエストパラメータを受け付ける
#        service =  Signs::CreateService.new(params)

        # ログイン処理の実行
#        @result_data = service.execute
@result_data = {
    token: "dummy_token",
    account_id: "dummy_account_id"
}        
        render json: @result_data
    end
    
    # ログアウトAPI
    def delete
        puts "------params: #{params}"
        
        @result = {}
        
        raise Application::Exceptions::ErrCode004Error.new
        
        render json: @result
    end
end