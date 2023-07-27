Rails.application.routes.draw do
  root to: "feeds#index"
  resources :albums
  resources :photos
  resources :follows

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
  devise_for :users
  get '/users/follower', to: 'users#follower'
  get '/users/:id', to: 'users#show'
  post '/users/:followed_user_id/follow', to: 'users#follow', as: :follow_user
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
