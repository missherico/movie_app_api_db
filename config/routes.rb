Movies::Application.routes.draw do

  root 'movies#welcome'
  
  get 'movies/search', to: 'movies#search'
  post 'movies/search/result', to: 'movies#result', as: :search_result

  resources :movies


end
