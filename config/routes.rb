Rails.application.routes.draw do
  resources :carts
  get 'store/index'
  resources :products
  root :to => 'store#index'
  get 'say/hello'
  get 'say/goodbye'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
