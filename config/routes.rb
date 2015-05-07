Rails.application.routes.draw do
  match  ":status", to: "errors#show", via: :all, constraints: { status: /\d{3}/ }

  get    "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  root   "dashboard#show"

  scope "", as: :user do
    get   "/:username",      to: "users#show"
    put   "/:username",      to: "users#update"
    patch "/:username",      to: "users#edit"
  end
  get   "/:username/edit", to: "users#edit", as: :edit_user

  scope "/cohorts" do
    get "/:cohort",   to: "cohorts#show", as: :cohort
  end

  namespace :api do
    resources :users,     only: [:show, :index]
    resources :commits,   only: [:show, :index]
  end
end
