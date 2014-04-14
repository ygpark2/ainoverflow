AinOverflow::Application.routes.draw do

  # devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'


  # Questions
  resources :questions, :member => {:vote => :post, :tag => :get},
                            :collection => {:unanswered => :get , :hot => :get} do |question|
    resources :answers
    resources :flags
    resource :favorites
  end

  # Answers
  resources :answers, :member => {:vote => :post, :select => :post} do |answer|
    resources :comments
    resources :flags
  end

  #resources :comments do |comment|
  #  comment.resources :flags
  #end

  resources :search ,  :controller => 'search'

  # Feedbacks system
  resources :feedbacks

  # == Admin Namespace

  namespace :admin do |admin|
    resource :dashboard, :controller => :dashboard
    resources :questions, :member => {:ban => :put}
    resources :answers, :member => {:ban => :put}
    resources :users, :member => {:ban => :put}
  end

  root :controller => "home", :action => "index"
  get "/badges" , :controller => "home", :action => "badges"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
