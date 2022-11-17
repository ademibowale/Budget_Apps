# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  resources :users, only: [:index] do
    resources :groups, only: %i[index new create show destroy] do
      resources :expenses, only: %i[index new create show destroy]
    end
  end
  # root to  :"home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
