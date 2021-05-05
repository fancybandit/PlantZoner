Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/github/callback', to: 'sessions#create'

  get 'plants/:id/delete', to: 'plants#delete', as: 'delete_plant'
  get 'users/:user_slug/gardens/:id/delete', to: 'gardens#delete', as: 'delete_user_garden'

  resources :users, param: :slug do
    resources :gardens, only: [:show, :index, :new, :create, :edit]
  end
  resources :gardens do
    resources :plants, only: [:index, :new, :create]
  end
  resources :plants
  resources :growing_zones
end
