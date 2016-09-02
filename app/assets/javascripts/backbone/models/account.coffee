# 認証情報
class GameGui.Models.Account extends Backbone.Model
    urlRoot: '/accounts'
    idAttribute: "account_id"
    
    initialize: (account_id) ->
        @set('account_id', account_id)
    
    # アカウント情報を取得する
    fetchByToken: (token) ->
        params = {
            token: token
        }
        @fetch(data: params)
    
    # アカウントが対戦していない状態か否か
    isGameNotPlaying: ->
        game_status = @get('game_status')
        return (game_status == 'free')