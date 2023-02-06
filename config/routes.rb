# frozen_string_literal: true

Rails.application.routes.draw do
  get 'health', to: 'health#index'

  resources :billers, defaults: {format: :json}
  resources :bills, defaults: {format: :json}
  resources :entities, defaults: {format: :json}
end
