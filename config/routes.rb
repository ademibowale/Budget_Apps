Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index] do
    resources :groups, only: [:index, :new, :create, :show, :destroy] do
      resources :expenses, only: [:index, :new, :create, :show, :destroy]
    end
  end
  # root to  :"home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end