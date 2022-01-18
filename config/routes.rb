Rails.application.routes.draw do
  resources :displays
  resources :dashboards
  resources :entries
  resources :items
  resources :categories
  devise_for :users
  root "entries#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
