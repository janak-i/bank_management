Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "articles#index"
  post "/login",  to: "sessions#login"
  post "/signup", to: "sessions#signup"
  resources :users
  resources :accounts
  resources :transactions
end
