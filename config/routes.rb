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
  delete '/logout',  to: 'sessions#destroy'

end
