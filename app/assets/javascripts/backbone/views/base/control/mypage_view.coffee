# 管理対象
class GameGui.Views.Base.Control.MypageView extends Backbone.View

    el: '#mypage_panel'
    
    template: _.template JST['templates/base/control/mypage_panel']()
    
    initialize: (account_model) ->
        @account_model = account_model
    
    # パネルを閉じる
    close: ->
        console.log('mypage panel close')
        # マイページパネルを閉じる
        @remove()
    
    # パネルを初期表示する
    renderInit: ->
        console.log('mypage panel render init')
        @$el.html @template
        
        # マイページパネルにアカウント情報を反映する
        @outputAccountInfo()
                
        # Now Loading をフェードアウト
        @$el.find("#load_account_info_executing_img").hide('fade')

    
    # アカウント情報をパネルに出力する
    outputAccountInfo: ->
        @$el.find("#account_id_text").text(@account_model.get('user_name'))