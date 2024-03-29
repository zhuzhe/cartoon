Cartoon::Application.routes.draw do

  resources :quences

  resources :tags

  namespace :admin do
    resources :comics do

      collection do
        post :update_all_sections
        get :enable_list
        get :disable_list
        get :search
        post :search
      end

      member do
        post :update_section_list
        post :enable
        post :disable 
        post :add_tag
        post :recommand
      end
    end
  end

  resources :books

  resources :bookcases

  resources :users do
    collection do
      post 'favorite_book'
    end
  end

  resources :sections

  resources :pages

  resources :comics do
    collection do
      post 'search'
      get 'search'
      get 'hot'
      get 'latest'
    end
  end

  match 'login' => "sessions#new", :as => :login
  match 'logining' => "sessions#create", :as => :logining, :via => [:post]
  match 'logout' => "sessions#destroy", :as => :logout, :via => [:get, :post]

  match 'signup' => 'users#new', :as => :signup

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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
