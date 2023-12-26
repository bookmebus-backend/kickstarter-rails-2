Rails.application.routes.draw do
  devise_for :admins
  root 'home#index'

  authenticate :admin_user do
    root to: 'admin#index', as: :admin_root
  end
end
