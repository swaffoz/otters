Rails.application.routes.draw do

  # Search articles
  get 'search' => 'search#show'
  
  # Archived articles
  get 'archives' => 'articles#archives'
  get 'archives/:page' => 'articles#archives'
  # Colophon
  get 'colophon' => 'articles#colophon'
    
  # XML-RPC for MarsEdit
  post 'xmlrpc' => 'xmlrpc#xe_index'
  
  # RSS Feed
  get 'feed' => 'articles#feed'
  get 'feed' => redirect("/feed.rss")

  # Article routes, this comes last on purpose
  resources :articles, path: ''
  root :to => 'articles#index'
  get ':friendly_id' => 'articles#show'
  
end
