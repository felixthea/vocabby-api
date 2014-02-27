VocabbyRailsAPI::Application.routes.draw do
  resources :users
  resource :session
  resources :words

  get 'logged_in_check', to: 'sessions#logged_in'
end
