Rails.application.routes.draw do
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :orders
  resources :line_items
  resources :carts

  resources :statics do
    collection do 
      get :faq
    end
  end

  get 'store/index'
  resources :products do
    resources :reviews do
      get :like, on: :member  # on: :collection ==> action for many elements
    end
  end
  root :to => 'store#index'
  get 'say/hello'
  get 'say/goodbye'

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '(:locale)' do
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    resources :products do
        get :who_bought, :on => :member
    end
    root :to => 'store#index', :as => 'store'
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
