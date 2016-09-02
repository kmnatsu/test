Rails.application.routes.draw do
  get '/gui' => 'gui#top_page'
  post '/signs' => 'api/signs#create'
  delete '/signs/:account_id' => 'api/signs#delete'
  get '/accounts/:account_id' => 'api/accounts#index'
end
