Rails.application.routes.draw do
  resources :users
  resources :availabilities, only: :create

  resources :searches, only: [:new, :create, :update, :show]

  root "users#index"
end
