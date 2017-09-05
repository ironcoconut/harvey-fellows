Rails.application.routes.draw do
  devise_for :users

  resources :fellows, only: [:show]
  resources :contributions, only: [:create]

  root to: "fellows#index"
end
