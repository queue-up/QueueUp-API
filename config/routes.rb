# frozen_string_literal: true

Rails.application.routes.draw do
  resources :communication_data, only: %i[index create update]

  resources :devices, only: %i[index create] do
    delete :destroy, on: :collection
  end

  resources :discord_users, only: %i[show update]

  resources :notifications, only: [] do
    delete :destroy, on: :collection
  end

  resources :user, only: [] do
    post :sign_up, on: :collection
    post :sign_in, on: :collection
    patch :update_password, on: :collection
    get :validate_token, on: :collection
  end

  resources :league_matches, only: [:index]
  resources :league_messages, only: %i[create show]

  get 'league_profiles/by_discord/:id', to: 'league_profiles#discord'
  patch 'league_profiles/by_discord/:id/ranked_data', to: 'league_profiles#discord_update'
  get 'league_profiles/by_summoner_name/:region/:summoner_name', to: 'league_profiles#summoner_name'
  resources :league_profiles, only: %i[index create show] do
    patch :update,      on: :collection
    patch :ranked_data, on: :collection
  end

  post 'lfg_league_profiles/by_discord/:id', to: 'lfg_league_profiles#discord'
  resources :lfg_league_profiles, only: [:index]

  resources :league_suggestions, only: [:index] do
    patch :accept, on: :member
    patch :decline, on: :member
  end
end
