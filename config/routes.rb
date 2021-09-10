Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :update,:edit, :destroy] do
    resources :contacts, only: [:create, :update, :destroy]
  end

  resources :incidents, only: [:new, :create, :edit, :update]

  resources :journeys, only:[:create, :show] do
    resources :incidents, only: [:index, :edit, :update]
  end

  resources :ratings, only: [:create, :index]

  resources :messages, only: :create

  get "/splash", to: "pages#splash"
  get "/calling", to: "pages#calling"
  get "/navigation", to: "pages#navigation"
  get "/uikit", to: "pages#uikit"
  get "/survey_success", to: "pages#survey_success"
end
