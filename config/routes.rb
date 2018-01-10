Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'

  get 'credenciales', to: 'admins#new'
  get 'home', to: 'admins#show'
  resources :admins
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :patients
  
  get 'menu_pacientes', to: 'pages#patients_menu'
  get 'menu_citas', to: 'pages#dates_menu'
  
  root 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
