DriversEdDatabase::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  match 'students/list_students' => 'students#list_students'
  match 'students/search' => 'students#search'
  match 'students/print_office_record' => 'students#print_office_record'
  match 'students/print_class_labels' => 'students#print_class_labels'
  match 'students/find_class_labels' => 'students#find_class_labels'
  match 'students/find_class_payments' => 'students#find_class_payments'
  match 'students/list_class_payments' => 'students#list_class_payments'
  match 'students/print_class_payments' => 'students#print_class_payments'
  match 'students/find_class_printouts' => 'students#find_class_printouts'
  match 'students/print_class_printouts' => 'students#print_class_printouts'
  match 'payments/search' => 'payments#search'
  match 'payments/list_payments' => 'payments#list_payments'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

    resources :payments
    resources :students

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
    root :to => 'students#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
