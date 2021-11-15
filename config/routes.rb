Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users 
  namespace :admin do
    resources :users, except: :create
    post 'create_user' => 'users#create', as: :create_user
    patch 'update_user/:id', to: 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destory', as: :delete_user
  end
  
  resources :stocks
  resources :trades
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
