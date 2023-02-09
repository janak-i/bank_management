Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "articles#index"
  post "/login",  to: "sessions#login"
  post "/signup", to: "sessions#signup"
  post "/with", to: "accounts#withdraw"
  post "/credit", to: "transactions#credit_amount"
  post "/debit", to: "transactions#debit_amount"
  resources :users
  resources :accounts
  resources :transactions
end
