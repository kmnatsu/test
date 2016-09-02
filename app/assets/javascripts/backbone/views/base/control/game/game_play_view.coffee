# 管理対象
#   対戦コマンドAPI実行
#   チャレンジ実行ボタン
#   チャレンジ拒否ボタン
#   妨害許容ボタン
#   カード指定ボタン
#   色指定ボタン
class GameGui.Views.Base.Control.Game.GamePlayView extends Backbone.View

    el: '#game_play_panel'
    
    template: _.template JST['templates/base/control/game/game_play_panel']()
    
    initialize: (sign_model) ->
        @sign_model = sign_model
        
        # ゲームの情報を保持するオブジェクト
        @obj_game = null
        
        # 定期的に対戦の開始を確認する処理オブジェクト
        @interval_obj_check_game_start = null
        
        # 定期的に対戦の進行状況を確認する処理オブジェクト
        @interval_obj_check_game_progress = null
        
        # 定期的に対戦の進行を描画する処理オブジェクト
        @interval_obj_draw_game_progress = null
        
        # 共通のイベント監視定義
        @delegate_events_base = {}
        
        # 選択フォーム毎のイベント監視定義
        @delegate_events_selector_card = {}
        
        # イベント監視定義を更新する
        @updateDelegateEvents()
        
    # イベント監視定義を更新する
    updateDelegateEvents: ->
        
        # イベント監視定義を初期化する
        this.undelegateEvents()
        
        # イベント監視定義を設定する
        delegate_events_parameter = {}
        $.extend(delegate_events_parameter, @delegate_events_base, @delegate_events_selector_card)
        this.delegateEvents(delegate_events_parameter)
    
    # 指定時間後に対戦の開始を確認するように設定する
    makeReservationCheckGameStart: (m_seq)->
        @interval_obj_check_game_start = setTimeout =>
            @checkGameStart()
        , m_seq
    
    # 指定時間後に対戦の進行を確認するように設定する
    makeReservationCheckGameProgress: (m_seq)->
        @interval_obj_check_game_progress = setTimeout =>
            @checkGameProgress()
        , m_seq
    
    # 指定時間後に対戦の進行を描画するように設定する
    makeReservationDrawGameProgress: (m_seq) ->
        @interval_obj_draw_game_progress = setTimeout =>
            @drawGameProgress()
        , m_seq
    
    # パネルを破棄する
    close: ->
        console.log('game play panel close')
        
        # 定期処理設定を全て停止する
        @canselReservationCheckGameStart()
        @canselReservationCheckGameProgress()
        @canselReservationDrawGameProgress()
        
        @remove()
    
    # 対戦の開始を確認する設定を停止する
    canselReservationCheckGameStart: ->
        clearTimeout(@interval_obj_check_game_start)
    
    # 対戦の進行を確認する設定を停止する
    canselReservationCheckGameProgress: ->
        clearTimeout(@interval_obj_check_game_progress)
    
    # 対戦の進行を描画する設定を停止する
    canselReservationDrawGameProgress: ->
        clearTimeout(@interval_obj_draw_game_progress)
    
    # パネルの初期表示
    renderInit: ->
        console.log("game play panel render init")
        @$el.html @template
        
        # 0m秒後に対戦の開始を確認するように設定する
        @makeReservationCheckGameStart(0)

    
    # 対戦の開始を確認する
    checkGameStart: ->
        console.log('check game start')
        
        # 対戦状況を取得する
        if true
            
            # 対戦状況を取得できた場合
            if true
                
                # ゲームオブジェクトを生成
                @obj_game = new GameGui.Objs.Game('base data')
                
                # Now Loading をフェードアウト
                @$el.find("#game_play_now_loading_img").hide('fade')
                
                # 0m秒後に対戦の進行状況を確認するように設定する
                @makeReservationCheckGameProgress(0)
                
                # 0m秒後に対戦の進行状況を描画するように設定する
                @makeReservationDrawGameProgress(0)
    
    # 対戦の進行状況を確認する
    checkGameProgress: ->
        console.log('check game progress')
        
        # 対戦状況を取得する
        if true
            
            # 対戦状況を取得できた場合
            if true
                
                # ゲームの進行状況をアップデート
                @obj_game.updateData('latest data')
                
                # 10000m秒後に対戦の進行状況を確認するように設定する
                @makeReservationCheckGameProgress(10000)
        
    
    # 対戦の進行状況を描画する
    drawGameProgress: ->
        console.log('draw game progress')
        
        # ゲームの表示情報を更新する
        @obj_game.updateDrawData()
        
        # ゲームの表示情報を取得する
        @obj_game.getDrawData()
        
        # ゲームの表示情報に合わせて画面を描画する
        
        # 0m秒後に対戦の進行状況を描画するように設定する
        @makeReservationDrawGameProgress(0)
    
    # 提出するカードを選択する
    selectCard: (ev) ->
        console.log("select card")
        #console.log($(ev.target).attr('id'))
        
        