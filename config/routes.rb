Rails.application.routes.draw do
  get 'frees/index'
  root to: "frees#index"
end
