Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "style_pages#home"
    get "/friendcoff", to: "main_pages#home"
    get "/about", to: "main_pages#about"
    get "/signup", to: "users#new"
    resources :users, only: %i(show create new)
  end
end
