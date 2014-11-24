Rails.application.routes.draw do
  resources :users
  resources :availabilities, only: :create

  get  "/search", to: "search#new"
  post "/search", to: "search#create"

  root "users#index"
end
