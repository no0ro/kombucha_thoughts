Rails.application.routes.draw do
  # maps HTTP verbs to controller actions

  get '/' => "sessions#welcome" # root

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"

  get '/signup' => "users#new"
  post '/signup' => "users#create" 

  delete '/logout' => "sessions#destroy"

  get '/auth/:provider/callback' => 'sessions#omniauth'


  resources :brands, only: [:index]

  get '/reviews/newest_reviewed' => 'reviews#newest_reviewed'
    # Remember: must go above reviews resource, or will get routed to reviews/index

  get '/reviews/most_reviews' => 'reviews#most_reviews'

  resources :reviews
  # reviews/most_reviews

  # Models 
  # scope - 

  # Controller 
  # most_reviews

  # Views
  # most_reviews
 
  resources :kombuchas do 
    resources :reviews, only: [:new, :index]
    # /kombuchas/:kombucha_id/reviews/new
    # /kombuchas/:kombucha_id/reviews   
  end 

  resources :users, only: [:show, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
