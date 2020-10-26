Rails.application.routes.draw do
  root "posts#index"

  #ログイン用
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :posts #投稿用のコントローラーのURL
  resources :users #ユーザー用コントローラーのURL
end
