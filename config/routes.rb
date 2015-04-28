Rails.application.routes.draw do
  match  ":status", to: "errors#show", via: :all, constraints: { status: /\d{3}/ }

  get    "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  root   "dashboard#show"

  get    "/profile", to: "users#show"

  namespace :api do
    resources :commits, except: [:new, :edit]
    resources :users,   except: [:new, :edit]
  end
end
