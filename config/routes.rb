Xlmodel::Application.routes.draw do
  resources :users
  resources :fortumo

  root 'static_pages#home'

  match '/12345/fortumo', to: 'users#index', 						via: 'get'
  match '/help',     			to: 'static_pages#help',      via: 'get'
  match '/about',   	 		to: 'static_pages#about',     via: 'get'
  match '/contact',  			to: 'static_pages#contact',   via: 'get'

end
