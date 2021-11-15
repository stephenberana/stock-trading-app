Rails.application.routes.draw do
  devise_for :users, controller: {registrations: "registrations"}

  devise_scope :user do
    root 'pages#home'
  end

  resources :users 
  namespace :admin do
    resources :users, except: :create
    post 'create_user' => 'users#create', as: :create_user
    patch 'update_user/:id', to: 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destory', as: :delete_user
  end
  
  resources :stocks
  resources :trades

  resources :balances do
    collection do
      get 'deposit'
      get 'withdraw'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
