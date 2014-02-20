# -*- encoding : utf-8 -*-
Smschg::Application.routes.draw do

  root :to => "home#about"
  get "pages/index"

  get "pages/show"

  #get "admin" => "admin#doanh_nghieps"
  #root :to => yourController#index 
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  

  #root :to => "admin"
  get "home/index" => "home#index"
  get "home/about" => "home#about"
  get "home/blog" => "home#blog"
  get "home/pricing" => "home#pricing"
  get "home/login" => "home#login"
  
  #get "doanhnghieps/dangky"
  get "home/contact2" => "home#contact2"
  get "home/alt" => "home#alt"
  #get "homes/contact2"
  get "home/register" => "home#register"
  get "home/single" => "home#single"
  get "home/dividers" => "home#dividers"
  match "home/search", :controller => 'home', :action => 'search'
  #devise_for :users
  #ActiveAdmin.routes(self)

  #match '/index' => 'home#index'
  #get "assets/images/image001.png" => "assets#images#image001.png"
  resources :users
  resources :home
  #resources :phat_tems
  
   # root to: 'users#index'
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
  # match ':controller(/:action(/:id))(.:format)'
end
