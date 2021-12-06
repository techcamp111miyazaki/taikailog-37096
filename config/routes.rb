Rails.application.routes.draw do
  devise_for :users
  root to: 'events#index'
  resources :events, except: [:show] do
    collection do
      get 'search'
    end
    resources :matches do
      collection do
        get 'search'
      end
    end
  end
end
