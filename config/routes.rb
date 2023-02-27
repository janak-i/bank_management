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
  get "/check", to: "transactions#check_balance"
  get "/totalsum", to: "transactions#total_balance_sum"
  get "/select", to: "banks#select_loan"
  get "/taking_loan", to: "banks#take_loan"
  get "/simple_interest", to: "banks#calculate_simple_interest"
  resources :users
  resources :accounts
  resources :transactions
  resources :shares
  resources :stocks
  resources :banks
end
