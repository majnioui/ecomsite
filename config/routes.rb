Rails.application.routes.draw do
  resources :products
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/index'
  devise_for :users
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
