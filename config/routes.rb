Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'plants/:id/delete', to: 'plants#delete', as: 'delete_plant'

  resources :users do
    resources :gardens, only: [:new, :create, :index]
  end
  resources :gardens do
    resources :plants, only: [:new, :create, :index]
  end
  resources :plants
  resources :growing_zones
end
