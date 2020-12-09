Rails.application.routes.draw do
  root 'homes#top'
  get  '/signup',  to: 'users#new'
  resources :users
end
