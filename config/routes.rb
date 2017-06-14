Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#input_auth'
  get '/log', to: 'pages#home', as: 'log'
  post '/auth', to: 'pages#check_auth', as: 'check'
  post '/logout', to: 'pages#logout', as: 'logout'
  post '/update', to: 'pages#update', as: 'update'
end
