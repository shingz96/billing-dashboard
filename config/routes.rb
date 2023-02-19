# frozen_string_literal: true

Rails.application.routes.draw do
  get 'health', to: 'health#index'

  resources :billers, defaults: {format: :json}
  resources :bills, defaults: {format: :json} do
    member do
      get 'pdf'
    end
  end
  resources :entities, defaults: {format: :json}
end
