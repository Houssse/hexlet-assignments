# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  scope '(:locale)', locale: /en|ru/ do
    root 'home#index'

    resources :posts do
      resources :comments
    end
  end
  # END
end
