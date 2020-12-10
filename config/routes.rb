Rails.application.routes.draw do
  root 'homes#top'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end
