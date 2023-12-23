Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :dashboard
  end

  root 'pages#index'
end
