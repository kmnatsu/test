# 管理対象
#   認証情報
#   ログインフォームパネル
#   コントロールパネル
class GameGui.Views.BaseView extends Backbone.View

    el: '#gui'
    
    initialize: ->
        
        # 認証情報
        @sign_model = null
        
        # 認証情報の更新報告を監視する
        @listenTo App.mediator, 'finish:sign:update', (sign_model) =>

            # 認証情報を管理する
            @sign_model = sign_model
            
            # 認証情報の有無に応じたパネル表示に切り替える
            @authenticate()
        
        # 認証情報の破棄依頼を監視する
        @listenTo App.mediator, 'requested:sign:delete', () =>
            
            # ログアウトを実施する
            @execLogout()
        
        # トークンの失効報告を監視する
        @listenTo App.mediator, 'invalid:token:authenticate', () =>
            
            # 認証情報を破棄する
            @sign_model = null
            
            # 認証情報の有無に応じたパネル表示に切り替える
            @authenticate()
        
        

    # 認証情報の有無に応じて表示するパネルを制御する
    authenticate: ->
        
        # 認証情報を保持している場合
        if @sign_model?
            
            # 認証状態としてのパネル表示に切り替える
            @renderLogined()
    
        # 認証情報を保持していない場合
        else
            
            # 未認証状態としてのパネル表示に切り替える
            @renderNotLogin()
        
    # 認証状態としてのパネル表示に切り替える
    renderLogined: ->
        console.log("show control panel")
        
        # ログインフォームパネルを閉じる
        if @loginView?
            @loginView.close()
            @loginView = null
        
        # コントロールパネルを表示する
        unless @controlView?
            @$el.append '<div id="control_panel" class="control_panel_blk"></div>'
            @controlView = new GameGui.Views.Base.ControlView(@sign_model)
            @controlView.renderInit()
    
    # 未認証状態としてのパネル表示に切り替える
    renderNotLogin: ->
        console.log("show rogin panel")
        
        # コントロールパネルを閉じる
        if @controlView?
            @controlView.close()
            @controlView = null
        
        # ログインフォームパネルを表示する
        unless @loginView?
            @$el.append '<div id="login_panel" class="login_panel_blk"></div>'
            @loginView = new GameGui.Views.Base.LoginView
            @loginView.renderInit()
    
    # ログアウトを実施する
    execLogout: ->
        
        # アカウントに対する認証情報を削除
        @sign_model.destroyByToken()
            .done =>
                console.log('sign_model destroy success')
                
                # 認証情報を破棄
                @sign_model = null
                
                # 認証情報の有無に応じたパネル表示に切り替える
                @authenticate()
                
            .fail (jqXHR, textStatus, errorThrown) =>
                console.log('sign_model destroy fail')

                # トークンが失効されたよ と報告
                App.mediator.trigger('invalid:token:authenticate')