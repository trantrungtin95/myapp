Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts

  resources :statics do
    collection do 
      get :faq
    end
  end

  get 'store/index'
  resources :products
  root :to => 'store#index'
  get 'say/hello'
  get 'say/goodbye'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
