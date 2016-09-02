class Order < ActiveRecord::Base

    # オーダーエラーコード
    RESULT_ERROR_CODE_000 = "ORD_ERR_CODE_000"
    RESULT_ERROR_CODE_001 = "ORD_ERR_CODE_001"
    RESULT_ERROR_CODE_002 = "ORD_ERR_CODE_002"
    RESULT_ERROR_CODE_003 = "ORD_ERR_CODE_003"
    RESULT_ERROR_CODE_004 = "ORD_ERR_CODE_004"
    RESULT_ERROR_CODE_005 = "ORD_ERR_CODE_005"
    RESULT_ERROR_CODE_006 = "ORD_ERR_CODE_006"
    RESULT_ERROR_CODE_007 = "ORD_ERR_CODE_007"
    
    # 処理対象
    TARGET_TYPE_ACCOUNT = "account"
    TARGET_TYPE_SIGN = "sign"
    TARGET_TYPE_ROOM = "room"
    
    # 処理区分
    SECTION_SIGNIN = "signin"
    SECTION_SIGNOUT = "signout"
    SECTION_GAME_ENTRY = "game_entry"
    SECTION_REGISTER_PLAYER = "register_player"
    SECTION_REGISTRATION_FINISH = "registration_finish"
    SECTION_REGISTRATION_START = "registration_start"
    
    # 進行状況
    PROGRESS_STATUS_WAITING = "waiting"
    PROGRESS_STATUS_PROCESSING = "processing"
    PROGRESS_STATUS_FINISHED = "finished"
    PROGRESS_STATUS_FAILED = "failed"
    PROGRESS_STATUS_CANCELED = "canceled"
    
    # 正常終了リザルト区分
    PROGRESS_RESULT_OUTWORKING = "outworking"
    PROGRESS_RESULT_INTERRUPTION = "interruption"


    # 入力値をハッシュにして返却
    # return
    #   [Hash] 入力値
    def get_parameter_hash()
        JSON.parse(parameters, {symbolize_names: true})
    end
    
    # 処理結果詳細をハッシュにして返却
    # return
    #   [Hash] 処理詳細結果
    def get_result_detail_hash()
        JSON.parse(result_detail, {symbolize_names: true})
    end
end
