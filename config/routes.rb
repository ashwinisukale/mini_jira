# frozen_string_literal: true

Rails.application.routes.draw do
  resources :todos
  resources :roles
  resources :projects do
  	get 'users'
  	get 'todos'
  end
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
