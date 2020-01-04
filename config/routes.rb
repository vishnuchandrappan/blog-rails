Rails.application.routes.draw do

  get 'passsword_resets/new'

  get 'passsword_resets/edit'

  get 'sessions/new'

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'

  get '/signup', to: 'users#new'
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :account_activations, only: [:edit]
  resources :passsword_resets, only: [:new, :create, :edit, :update]
  resources :posts, only: [:new, :create, :destroy, :show, :edit, :update] do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end


end
