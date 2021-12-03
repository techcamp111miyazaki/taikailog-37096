Rails.application.routes.draw do
  devise_for :users
  root to: 'events#index'
  resources :events, except: [:show] do
    resources :matches
  end
end
