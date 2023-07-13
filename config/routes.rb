Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "/api/v1/merchants", to: "merchants#index"
  namespace :api do 
    namespace :v1 do 
      resources :merchants, only: [:index, :show] do 
        resources :items, only: [:index], controller: "merchants/items"
    
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        member do
          get :merchant, to: "items/merchants#show"
        end
      end
    end 


  end 
end