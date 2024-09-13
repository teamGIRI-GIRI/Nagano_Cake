Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    
    resources :items, only: [:index, :show]
    
    resource :customers, only: [:show, :edit, :update]
      get "/customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
      patch "/customers/withdraw" => "customers#withdraw", as: "withdraw"
      
    resources :cart_items, only: [:index, :update, :destroy, :create]
      delete "/cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all"
      
    resources :orders, only: [:new, :create, :index, :show]
      post "/orders/confirm" => "orders#confirm", as: "confirm"
      get "/orders/thanks" => "orders#thanks", as: "thanks"
      
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  
  namespace :admin do
    get "/admin" => "homes#top"
    
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    
    resources :genres, only: [:index, :create, :edit, :update]
    
    resources :customers, only: [:index, :show, :edit, :update]
    
    resources :orders, only: [:show, :update]
    
    patch "/admin/order_details/:id" => "order_details#update", as: "update"
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
