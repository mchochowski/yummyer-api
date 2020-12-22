# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  namespace :v1 do
    resources :places, only: %w[index]
  end
end
