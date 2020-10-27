Rails.application.routes.draw do
  devise_for :users
  root to: 'movies#index'
  get '/:id/favorites', to: 'users#favorites', as: :favorites
  get '/:id/pending', to: 'users#pending', as: :pending
  get '/:id', to: 'movies#show', as: :show
  get 'movie/new', to: 'movies#new', as: :new
  post "/:id", to: 'movies#create', as: :create
  patch 'movie/:id', to: 'movies#update', as: :movie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
