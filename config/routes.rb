Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "style_pages#home"
  end
end
