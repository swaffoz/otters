Rails.application.routes.draw do

  resources :articles
  root :to => 'articles#index'
  
  # Search articles
  get "search" => 'search#show'
  
  # XML-RPC for MarsEdit
  get 'xmlrpc/xe_index'
  post 'xmlrpc' => 'xmlrpc#xe_index'
  
  # RSS Feed
  get 'feed' => 'articles#feed'
  get 'feed' => redirect("/feed.rss")

end
