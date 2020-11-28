Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :root, to: 'welcome#index'

  get '/merchants/:merchant_id/items', to: 'items#index'
  post '/merchants', to: 'merchants#index'
  get '/merchants',  to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id', to: 'merchants#edit'
  get '/merchants/:id', to: 'merchants#show'
  patch '/merchants/:id', to: 'merchants#update'
  put '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'
  # resources :merchants do
  #   resources :items, only: [:index]
  # end


  get '/items/:item_id/reviews/new', to: 'items#new'
  post '/items/:item_id/reviews', to: 'items#create'

  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'

  # resources :items, only: [:index, :show] do
    # resources :reviews, only: [:new, :create]
  # end

  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  put '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  # resources :reviews, only: [:edit, :update, :destroy]










  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  get '/registration', to: 'users#new', as: :registration
  resources :users, only: [:create, :update]
  patch '/user/:id', to: 'users#update'
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'
  post '/orders', to: 'user/orders#create'
  get '/profile/orders', to: 'user/orders#index'
  get '/profile/orders/:id', to: 'user/orders#show'
  delete '/profile/orders/:id', to: 'user/orders#cancel'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'








  get '/merchant', to: 'merchant/dashboard#index'
  get '/merchant/orders/:id', to: 'merchant/orders#show'
  get '/merchant/items', to: 'merchant/items#index'
  post '/merchant/items', to: 'merchant/items#create'
  get '/merchant/items/new', to: 'merchant/items#new'
  get '/merchant/items/:id/edit', to: 'merchant/items#edit'
  patch '/merchant/items/:id', to: 'merchant/items#update'
  put '/merchant/items/:id', to: 'merchant/items#update'
  delete '/merchant/items/:id', to: 'merchant/items#destroy'
  put '/merchant/items/:id/change_status', to: 'merchant/items#change_status'
  get '/merchant/items/:id/fulfull/:order_item_id', to: 'merchant/orders#fulfill'

  get '/merchant/discounts', to: 'merchant/discounts#index'
  post '/merchant/discounts', to: 'merchant/discounts#create'
  get '/merchant/discounts/new', to: 'merchant/discounts#new'
  get '/merchant/discounts/:id', to: 'merchant/discounts#edit'
  get '/merchant/discounts/:id', to: 'merchant/discounts#show'
  patch '/merchant/discounts/:id', to: 'merchant/discounts#update'
  put '/merchant/discounts/:id', to: 'merchant/discounts#update'
  delete '/merchant/discounts/:id', to: 'merchant/discounts#destroy'


  # namespace :merchant do
  #   get '/', to: 'dashboard#index', as: :dashboard
  #   resources :orders, only: :show
  #   resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
  #   put '/items/:id/change_status', to: 'items#change_status'
  #   get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'
  #   resources :discounts
  # end

  get '/admin', to: 'admin/dashboard#index'
  get '/admin/merchants/:id', to: 'admin/merchants#show'
  patch '/admin/merchants/:id', to: 'admin/merchants#update'
  put '/admin/merchants/:id', to: 'admin/merchants#update'
  get '/admin/users', to: 'admin/users#index'
  get '/admin/users/:id', to: 'admin/users#show'
  patch '/admin/orders/:id/ship', to: 'admin/orders#ship'
  #
  # namespace :admin do
  #   get '/', to: 'dashboard#index', as: :dashboard
  #   resources :merchants, only: [:show, :update]
  #   resources :users, only: [:index, :show]
  #   patch '/orders/:id/ship', to: 'orders#ship'
  end
