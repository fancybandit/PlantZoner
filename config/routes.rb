Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/github/callback', to: 'sessions#create'

  get 'users/github_affiliated', to: 'users#scope', as: 'user_scope'
  get 'users/:slug/delete', to: 'users#delete', as: 'delete_user'

  get 'plants/:id/delete', to: 'plants#delete', as: 'delete_plant'

  get 'users/:user_slug/gardens/:id/delete', to: 'gardens#delete', as: 'delete_user_garden'

  resources :users, param: :slug do 
    resources :gardens
  end
  resources :gardens do
    resources :plants, only: [:index, :new, :create, :edit, :update]
  end
  resources :growing_zones do
    resources :gardens, only: [:index]
  end
  resources :plants
end
