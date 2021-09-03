Rails.application.routes.draw do
  get 'posts_imports/new'
  get 'posts_imports/create'
  get 'comments/create'
  get 'comments/destroy'
  root to: 'posts#index'

  resources :posts do
    resources :comments
  end

  resources :posts_imports, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
