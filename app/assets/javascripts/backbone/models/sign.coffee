# 認証情報
class GameGui.Models.Sign extends Backbone.Model
    urlRoot: '/signs'
    
    # アカウントIDとパスワードを指定して認証情報を取得
    fetchByAccountIdAndPassword: (account_id, password) ->
        input_params = 
            account_id: account_id
            password: password
        @set(input_params)
        @save()
    
    # トークンを指定して認証情報を削除
    destroyByToken: ->
        console.log('destroyByToken exec')
        params = 
            token: @get('token')

        opt = {
            data: params
            processData: true
        }
        @set('id', @get('account_id'))
        @destroy(opt)