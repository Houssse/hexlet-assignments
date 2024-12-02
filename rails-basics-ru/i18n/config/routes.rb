# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  scope '(:locale)', locale: /en|ru/ do
    root 'home#index'

    resources :posts do
      resources :comments, module: :posts
    end
  end
  # END
end
