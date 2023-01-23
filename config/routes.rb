Rails.application.routes.draw do
  devise_for :users
  
  root to: "frees#index"
  resources :frees do
    resources :orders, only: [:index, :create]
  end
end
