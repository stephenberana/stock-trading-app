Rails.application.routes.draw do
  devise_for :users, controller: {registrations: "registrations"}

  devise_scope :user do
    root 'pages#home'
  end

  resources :users 
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
