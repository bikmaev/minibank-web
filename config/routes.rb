# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")

  # root 'pages#index'
  post '/', to: 'clients#create'
  # post '/login', to: 'clients#login'
  # resources :clients, only: [:new, :create]

  get 'sessions/new'
  root 'pages#index'

  resources :clients, only: %i[show edit update create] do
    resources :accounts, only: %i[show edit update create]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
