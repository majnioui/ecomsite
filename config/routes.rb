Rails.application.routes.draw do
  resources :products
  resources :categories
  resources :order_items, only: %i(create update destroy)
  devise_for :users
  get 'cart', to: 'cart#show'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/index'
  root 'products#index'
end
