Rails.application.routes.draw do
  resources :user

  post "/login", to: "user#login"
end
