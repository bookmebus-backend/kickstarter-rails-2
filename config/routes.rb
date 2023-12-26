Rails.application.routes.draw do
  namespace :admin do
    resources :categories
  end
  devise_for :admins
  root 'home#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  authenticate :admin_user do
    root to: 'admin#index', as: :admin_root
  end

  get "admin" => "admin#index"
end
