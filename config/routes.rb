Rails.application.routes.draw do
  get 'welcome/index'
  resources :displays
  resources :dashboards
  resources :entries
  resources :items
  resources :categories
  devise_for :users
  root "welcome#index"
end
