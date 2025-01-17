Rails.application.routes.draw do
  get "ping", to: "ping#index"

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "sites#index"

  resources :sites
end
