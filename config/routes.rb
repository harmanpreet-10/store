Rails.application.routes.draw do
  root "products#index"

  resources :products do
    resources :subscribers, only: [:create, :destroy]
  end

  post "products/:id/buy", to: "products#buy", as: :buy_product

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout
  get "products/:product_id/subscribers/:id/unsubscribe",
    to: "subscribers#destroy",
    as: :unsubscribe_product_subscriber
end