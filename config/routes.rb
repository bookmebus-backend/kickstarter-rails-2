Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :dashboard do
      resources :products
    end
  end

  root 'pages#index'
end
