Rails.application.routes.draw do

  resources :articles
  root :to => 'articles#index'
  get "search" => 'search#show'
  
end
