Rails.application.routes.draw do
  get '/' => "sessions#welcome" # root

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"

  get '/signup' => "users#new"
  post '/signup' => "users#create" 

  delete '/logout' => "sessions#destroy"

  get '/auth/:provider/callback' => 'sessions#omniauth'

  resources :reviews
  
  resources :kombuchas do 
    resources :reviews, only: [:new, :index]
  end 

  resources :brands

  resources :users, only: [:show, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
