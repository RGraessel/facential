Rails.application.routes.draw do
  get '/users/topics' => 'topics#all_topics'
  get '/users/lessons' => 'lessons#all_lessons'
  resources :lesson_responses


  resources :users do
    member do
      get :view_archived_video
    end
  resources :courses do
    resources :topics do
      resources :lessons
      end
    end
  end

  root 'users#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  # post '/login' => 'users#show'
  get '/logout' => 'sessions#destroy'

  get '/session' => 'lessons#session_action'
  post '/start/:session_id/:lesson_id' => 'lessons#start_recording'
  post '/stop/:archive_id' => 'lessons#stop_recording'
  get '/view' => 'lessons#view_archived_video'
  get '/rerecord' => 'lessons#rerecord'
  get '/submit' => 'lessons#submit'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  # root 'users#show'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
