Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'

  get 'credenciales', to: 'admins#new'
  get 'home', to: 'admins#show'
  resources :admins
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  root 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
