Rails.application.routes.draw do
  get 'users/new'

  get '/about', to: 'static_pages#about'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
end
