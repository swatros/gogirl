Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :update, :destroy] do
    resources :contacts, only: [:create, :update, :destroy]
  end

  resources :incidents, only: [:create, :index, :update]
  resources :ratings, only: [:create, :index]

  get "/uikit", to: "pages#uikit"
end
