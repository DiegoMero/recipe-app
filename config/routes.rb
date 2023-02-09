Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "foods#index"
  
  resources :recipes, only: %i[index new create show destroy]
  
  get '/public_recipes', to: 'recipe#public_recipe'

  resources :foods, only: [:index, :new, :create, :destroy]
end
