WaterCraft::Application.routes.draw do
	
	get "fight/show/:id" => "fight#show"
	get "fight/train" => "fight#train"

	get "/rankings/rank/:id" => "rankings#rank"

	
	get "/skills/edit" => "skills#edit"
	post "/skills/update" => "skills#update"
	
	resources :messages

  	devise_for :users, :controllers => { :registrations => "registrations" }
  	
	root :to => "Index#index"
	
	get "/profile/show/:id" => "profile#show"
	get "/profile/edit" => "profile#edit"
	get "/profile/index" => "profile#index"

	get "/profile/create/:id" => "profile#create"
	get "/profile/new" => "profile#new"



  #get "skills/edit"
  #get "skills/show"
  
  	#get "messages/index"

  	#match "messages/show/:id" => "messages#show"

  	#get "messages/new/:id" => "messages#new"
  	
  	#get "messages/new" => "messages#new"
  	#post "messages/create" => "messages#create"
  	
  	#delete "messages/delete/:id" => "messages#delete"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
