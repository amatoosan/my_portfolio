Rails.application.routes.draw do
  root 'homes#top'

  #react練習用
  get '/test',  to: 'homes#test'
  get '/test.json',  to: 'homes#test'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  #application.html.erbのJS読み込み部分を消すとなぜか/logoutにgetしちゃうので仮置き
  get '/logout',  to: 'sessions#destroy'
  delete '/logout',  to: 'sessions#destroy'

end
