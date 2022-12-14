Rails.application.routes.draw do
  root 'home#index'
  get "/home", to: "homes#index"
  
  resources :groups do 
    resources :expenses, only: [:new, :create, :destroy]
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
