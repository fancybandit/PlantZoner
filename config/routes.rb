Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :gardens
  resources :plants
  resources :growing_zones
  resources :users
end
