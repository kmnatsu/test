# 管理対象
#   対戦エントリーパネル
#   対戦プレイパネル
#   対戦結果パネル
class GameGui.Views.Base.Control.GameView extends Backbone.View

    el: '#game_panel'
    
    template: _.template JST['templates/base/control/game_panel']()
    
    initialize: (sign_model) ->
        @sign_model = sign_model
        
        # 対戦のエントリー完了報告を監視する
        @listenTo App.mediator, 'finish:game:entry',  =>

            # 対戦プレイパネルを活性化する
            @activateGamePlayPanel()
    
    # パネルを破棄する
    close: ->
        console.log('game panel close')
        
        # 対戦エントリーパネルを閉じる
        @closeGameEntryPanel()
        
        # 対戦プレイパネルを閉じる
        @closeGamePlayPanel()
        
        @remove()
    
    # 対戦エントリーパネルを閉じる
    closeGameEntryPanel: ->
        console.log("close game entry panel")
        if @gameEntryView?
            @gameEntryView.close()
            @gameEntryView = null
        
    # 対戦プレイパネルを閉じる
    closeGamePlayPanel: ->
        console.log("close game play panel")
        if @gamePlayView?
            @gamePlayView.close()
            @gamePlayView = null
    
    # パネルの初期表示
    renderInit: ->
        console.log("game panel render init")
        @$el.html @template
        
        # プレイヤー情報の有無に応じてパネル表示を切り替える
        @renderChangeActiveView()
    
    # 管理対象のパネルの表示を切り替える
    renderChangeActiveView: ->
        
        # アカウント情報を取得する
        if true
            
            # アカウント情報を取得できた場合
            if true
                
                # アカウントがプレイヤー情報を持たない場合
                if true
                    
                    # 対戦エントリーパネルを活性化する
                    @activateGameEntryPanel()
                    
                # アカウントがプレイヤー情報を持つ場合
                else
                
                    # 対戦プレイパネルを活性化する
                    @activateGamePlayPanel()
    
    # 対戦エントリーパネルを活性化
    activateGameEntryPanel: ->
        console.log("activate game entry panel")
        
        # 対戦プレイパネルを閉じる
        @closeGamePlayPanel()
        
        # 対戦エントリーパネルを開く
        unless @gameEntryView?
            @$el.append '<div id="game_entry_panel" class="game_entry_panel_blk"></div>'
            @gameEntryView = new GameGui.Views.Base.Control.Game.GameEntryView(@sign_model)
            @gameEntryView.renderInit()
    
    # 対戦プレイパネルを活性化
    activateGamePlayPanel: ->
        console.log("activate game play panel")
        
        # 対戦エントリーパネルを閉じる
        @closeGameEntryPanel()
        
        # 対戦プレイパネルを開く
        unless @gamePlayView?
            @$el.append '<div id="game_play_panel" class="game_play_panel_blk"></div>'
            @gamePlayView = new GameGui.Views.Base.Control.Game.GamePlayView(@sign_model)
            @gamePlayView.renderInit()