Rails.application.routes.draw do
  get '/' => "session#welcome"
  
  
  resources :reviews
  resources :kombuchas
  resources :brands
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
