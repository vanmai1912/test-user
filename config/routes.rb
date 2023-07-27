Rails.application.routes.draw do
  resources :albums
  resources :photos

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
