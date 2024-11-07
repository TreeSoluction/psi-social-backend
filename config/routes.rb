Rails.application.routes.draw do
  resources :user, :authentication

  post "/login", to: "authentication#login"
end
