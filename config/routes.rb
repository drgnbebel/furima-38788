Rails.application.routes.draw do
  devise_for :users
  get 'frees/index'
  root to: "frees#index"
end
