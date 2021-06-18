Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "style_pages#home"
    get "/friendcoff", to: "main_pages#home"
    get "/about", to: "main_pages#about"

    get "/signup", to: "users#new"

    get "/signin", to: "sessions#new"
    post "/signin", to: "sessions#create"
    delete "/signout", to: "sessions#destroy"

    resources :users, only: %i(new create show)
  end
end
