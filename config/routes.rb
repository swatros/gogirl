Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :update,:edit, :destroy] do
    resources :contacts, only: [:create, :update, :destroy]
  end

  resources :incidents, only: [:create, :index, :update]
  resources :ratings, only: [:create, :index]

  get "/navigation", to: "pages#navigation"
  get "/uikit", to: "pages#uikit"
end
