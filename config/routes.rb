VocabbyRailsAPI::Application.routes.draw do
  resources :users
  post 'session', to: 'sessions#create', via: [:options]
  post 'find_current_user', to: 'sessions#find_current_user', via: [:options]
  resource :session
  resources :words
  get 'logged_in_check', to: 'sessions#logged_in'
end
