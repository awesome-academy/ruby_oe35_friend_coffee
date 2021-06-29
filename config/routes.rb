Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "main_pages#home"
    get "/friendcoff", to: "main_pages#home"
    get "/about", to: "main_pages#about"
    get "/signup", to: "users#new"
    get "/signin", to: "sessions#new"
    post "/signin", to: "sessions#create"
    get "/signout", to: "sessions#destroy"
    resources :products, only: :index
    resources :carts
    resources :cart_items
    resources :categories, only: %i(index show) do
      resources :products, only: %i(index show)
    end
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, expect: %i(index show destroy)
  end
end
