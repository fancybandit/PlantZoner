Rails.application.routes.draw do
  resources :gardens
  resources :plants
  resources :growing_zones
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
