# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    resources :movies do
      # BEGIN
      resources :comments, only: %i[index new create edit update destroy], module: :movies
      resources :reviews, only: %i[index new create edit update destroy], module: :movies
      # END
    end

    resources :reviews, only: %i[index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
