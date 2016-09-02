# 管理対象
#   対戦エントリーAPI実行
#   対戦ルール選択フォーム
#   キャラ選択フォーム
#   キャラコスチューム選択フォーム
#   対戦エントリー実行ボタン
#   戻るボタン
class GameGui.Views.Base.Control.Game.GameEntryView extends Backbone.View

    el: '#game_entry_panel'
    
    template: _.template JST['templates/base/control/game/game_entry_panel']()
    
    initialize: (sign_model) ->
        # API実行用トークン
        @sign_model = sign_model
        
        # 対戦ルール取得結果
        @game_rule_colection = null
        
        # アカウント情報取得結果
        @account_info_colection = null
        
        # 選択フォームで選択している対象
        @select_game_rule_id = null
        @select_chara_id = null
        @select_costume_id = null
        
        # 共通のイベント監視定義
        @delegate_events_base = {
            'click #game_entry_back_btn': 'backGameEntry'
            'click #game_entry_exec_btn': 'execGameEntry'
        }
        
        # 選択フォーム毎のイベント監視定義
        @delegate_events_selector_game_rule = {}
        @delegate_events_selector_chara = {}
        @delegate_events_selector_costume = {}
        
        # イベント監視定義を更新する
        @updateDelegateEvents()
        
    # イベント監視定義を更新する
    updateDelegateEvents: ->
        
        # イベント監視定義を初期化する
        this.undelegateEvents()
        
        # イベント監視定義を設定する
        delegate_events_parameter = {}
        $.extend(delegate_events_parameter, @delegate_events_base, @delegate_events_selector_game_rule, @delegate_events_selector_chara, @delegate_events_selector_costume)
        this.delegateEvents(delegate_events_parameter)
    
    # パネルを破棄する
    close: ->
        console.log('game entry panel close')
        
        @remove()
        
    # パネルの初期表示
    renderInit: ->
        console.log("game entry panel render init")
        @$el.html @template
        
        # 対戦ルールを取得する
        #if true
            
            # 対戦ルールを取得できた場合
            #if true
                
                # 対戦ルール選択フォームを表示する
                
                # イベント監視定義を更新する
                
                # 対戦ルールローディング画面をフェードアウト
        
        # 所有キャラと所有コスチュームを取得する
        #if true
            
            # 所有キャラと所有コスチュームを取得できた場合
            #if true
                
                # キャラ選択フォームを表示する
                
                # コスチューム選択フォームを表示する
                
                # イベント監視定義を更新する
                
                # キャラローディング画面をフェードアウト
                
                # コスチュームローディング画面をフェードアウト

    # 対戦のエントリーを止める
    backGameEntry: ->
        console.log('abort game entry')
        
        # 対戦のエントリー中断を報告する
        App.mediator.trigger('abort:game:entry')
    
    # 対戦のエントリーを実施する
    execGameEntry: ->
        console.log('exec game entry')
        
        # 対戦エントリー実行中パネルを表示する
        
        # 対戦エントリーを実行する
        if true
            
            # 対戦エントリーが完了した場合
            if true
                
                # 対戦のエントリー完了を報告する
                App.mediator.trigger('finish:game:entry')
    
    # 対戦ルールを選択する
    selectGameRule: (ev) ->
        console.log('select game rule')
        #console.log($(ev.target).attr('id'))
    
    # 対戦用キャラを選択する
    selectChara: (ev) ->
        console.log('select chara')
        #console.log($(ev.target).attr('id'))
    
    # 対戦用コスチュームを選択する
    selectCostume: (ev) ->
        console.log('select costume')
        #console.log($(ev.target).attr('id'))
        