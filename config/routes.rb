Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'

  namespace :admin do
    namespace :v1 do
      get 'home' => 'home#index'
      resources :categories
      resources :products
      resources :coupons
    end
  end

  namespace :storefront do
    namespace :v1 do
      get 'home' => 'home#index'
      resources :products, only: [:index, :show]
      resources :categories, only: [:index]
      resources :wish_items, only: [:index, :create, :destroy]
      resources :checkouts
      post "/coupons/:coupon_code/validations", to: "coupon_validations#create"
    end
  end
end
