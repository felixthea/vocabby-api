VocabbyRailsAPI::Application.routes.draw do
  resources :users
  resource :session
  resources :words
end
