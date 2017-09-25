Rails.application.routes.draw do
  root 'principal#show'
  get 'credenciales', to: 'admins#new'
  get 'home', to: 'admins#show'
  resources :admins
end
