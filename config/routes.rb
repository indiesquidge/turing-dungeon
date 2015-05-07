Rails.application.routes.draw do
  match  ":status", to: "errors#show", via: :all, constraints: { status: /\d{3}/ }

  get    "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  root   "dashboard#show"

  get "/:username", to: "users#show",  as: :user
  get "/graphs/d3", to: "data#show",   as: :graph

  scope "/cohorts" do
    get "/:cohort",   to: "cohorts#show", as: :cohort
  end

  namespace :api do
    resources :users,     only: [:show, :index]
    resources :commits,   only: [:show, :index]
  end

end
