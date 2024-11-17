Rails.application.routes.draw do
  resources :user, :authentication, :psi

  post "/login", to: "authentication#login"
  get "/psi/have/:id", to: "psi#have"
end
