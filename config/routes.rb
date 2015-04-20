Rails.application.routes.draw do
  root "dashboard#show"
  get "/profile", to: "users#show"
end
