Rails.application.routes.draw do
  root 'home#index'
  resources :albums, only: [:index, :show, :update] do
    collection do
      get :populate, action: :populate
    end
  end

  resources :tags, except: [:show]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
