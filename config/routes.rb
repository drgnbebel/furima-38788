Rails.application.routes.draw do
  devise_for :users
  
  root to: "frees#index"
  resources :frees
  resources :orders, only: [:index, :create]
end
