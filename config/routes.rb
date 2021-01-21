Rails.application.routes.draw do
  root 'homes#top'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get  '/creation',  to: 'questions#new'
  post '/creation',  to: 'questions#create'
  resources :questions

  #react練習用
  get '/test',      to: 'homes#test'
  get '/test.json', to: 'homes#test'

end
