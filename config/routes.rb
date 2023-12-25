Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  get 'cart',  to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  get 'admin/orders', to: 'orders#admin_index'
  resources :products
  resources :orders
  resources :order_statuses
  resources :order_items

  

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
