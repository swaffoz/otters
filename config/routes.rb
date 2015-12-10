Rails.application.routes.draw do

  get 'xmlrpc/xe_index'

  resources :articles
  root :to => 'articles#index'
  
  # Search articles
  get "search" => 'search#show'
  
  # XML-RPC for MarsEdit
  post 'xmlrpc' => 'xmlrpc#xe_index'
end
