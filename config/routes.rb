Rails.application.routes.draw do
  
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users do
    get :follow, on: :member # Route for 1 objects
    get :unfollow, on: :member
  end
  resources :orders
  resources :line_items
  resources :carts
  # resources :followings, only: [:create] # Default: create 7 actions: index, show, edit, update, create, destroy, new
  # GET: read data from system
  # POST/PUT/PATCH/DELETE: change data in system

  resources :statics do
    collection do 
      get :faq
    end
  end

  get 'store/index'
  resources :products do
    resources :reviews do
      get :like, on: :member  # on: :collection ==> action for many elements
      get :dislike, on: :member
      
      resources :comments
    end
    get :luotxem, on: :member
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
