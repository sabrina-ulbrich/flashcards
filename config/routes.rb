Flashcards::Application.routes.draw do

  root :to => 'users#index'
   
  match "/cards/start_study/:card_set_id" => "cards#start_study", :as => "start_study"
  match "/cards/known/:card_id" => "cards#known", :as => "known_card"
  match "/cards/unknown/:card_id" => "cards#unknown", :as => "unknown_card"
  match "cards/new/:card_set_id" => "cards#new", :as => "new_card_in_set"
  match "/card_sets/current_user" => "card_sets#currentuser", :as => "card_set_current"
  
  match "users/logout" => "users#logout", :as => "logout"
  match "users/edit" => "users#edit", :as => "edit"
 
  
  resources :users do
    collection do
      get :login
      post :login_submit
    end
  end
  
 resources :cards do
    member do
      get :study_question 
      get :study_answer
    end
  end
  
  resources :card_sets

  
  
  
  
  
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
