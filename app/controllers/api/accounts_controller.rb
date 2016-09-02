class Api::AccountsController < Api::Base

    # アカウント情報取得API
    # スタブとして仮実装中
    def index
        puts "------params: #{params}"
        
        @result = {
            status: "free",
            game_status: "free",
            user_name: "stub_user_name",
            game_id: nil,
        }

        #raise Application::Exceptions::ErrCode006Error.new
        
        render json: @result
    end
end