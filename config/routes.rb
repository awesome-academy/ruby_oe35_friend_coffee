Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "main_pages#home"

    namespace :admin do
      root "main_pages#dashboard"
      get "signin", to: "admin_sessions#new"
      post "signin", to: "admin_sessions#create"
      get "signout", to: "admin_sessions#destroy"
      resources :categories
      resources :products
      resources :users
      resources :categories do
        resources :products
      end
    end

    get "/friendcoff", to: "main_pages#home"
    get "/about", to: "main_pages#about"
    get "/signup", to: "users#new"
    get "/signin", to: "sessions#new"
    post "/signin", to: "sessions#create"
    get "/signout", to: "sessions#destroy"
    resources :products, only: %i(index show)
    resources :carts
    resources :cart_items
    resources :orders
    resources :categories, only: %i(index show) do
      resources :products, only: %i(index show)
    end
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, expect: %i(index show destroy)
  end
end
