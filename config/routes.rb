Xlmodel::Application.routes.draw do
  resources :users

  root 'static_pages#home'

  match '/2974087962/fortumo', 	to: 'users#index', 						via: 'get'
  match '/help',     						to: 'static_pages#help',      via: 'get'
  match '/about',   	 					to: 'static_pages#about',     via: 'get'
  match '/contact',  						to: 'static_pages#contact',   via: 'get'

end
