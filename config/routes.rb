Rails.application.routes.draw do
  resources :roles
  resources :users, except: [:new]
  get 'posts_imports/new'
  get 'posts_imports/create'
  get 'comments/create'
  get 'comments/destroy'
  root to: 'posts#index'

  # register
  get '/register', to: 'auth#form_register', as: 'form_register'
  post '/register', to: 'auth#register', as: 'register_post'

  # login
  get '/login', to: 'auth#form_login', as: 'form_login'
  post '/login', to: 'auth#login', as: 'login_post'

  # logout
  delete '/logout/:id', to: 'auth#logout', as: 'user_logout'

  resources :posts do
    resources :comments
  end

  resources :searches
  resources :posts_imports, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
