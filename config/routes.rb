Movies::Application.routes.draw do

  resources :movies

  get 'movies/search', to: 'movies#search'

  root 'movies#index'


end
