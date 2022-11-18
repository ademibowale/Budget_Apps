# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  device_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    authenticated :user do
      root 'groups#index', as: :authenticated_root
    end
    unauthenticated do
      root 'users#index', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index] do
    resources :groups, only: %i[index new create show destroy] do
      resources :expenses, only: %i[index new create show destroy]
    end
  end
  # root to  :"home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
