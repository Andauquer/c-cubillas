Rails.application.routes.draw do
  root 'principal#show'
  get 'registro', to: 'admins#new'
  get 'home', to: 'admins#show'
  resources :admins, except: [:new]
end
