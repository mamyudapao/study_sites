Rails.application.routes.draw do
  root "posts#index"

  #ログイン用
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :posts ,:only =>[:new, :create]
  resources :users #ユーザー用コントローラーのURL
end
