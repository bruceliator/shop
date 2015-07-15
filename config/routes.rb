Rails.application.routes.draw do
  mount Shoppe::Engine => "/shoppe"
  scope ":locale", locale: /en|ua/ do
    devise_for :users, :controllers => { registrations: 'registrations' }
    get 'product/:permalink', to: 'products#show', as: 'product'
    post 'product/:permalink', to: 'products#buy', as: 'buy'
    root :to => 'products#index'
    get 'basket', to: 'orders#show'
    delete 'basket', to: 'orders#destroy'
    match 'checkout', to: 'orders#checkout', as: 'checkout', via: [:get, :patch]
    match 'checkout/pay', to: 'orders#payment', as: 'checkout_payment', via: [:get, :post]
    match 'checkout/confirm', to: 'orders#confirmation', as: 'checkout_confirmation', via: [:get, :post]
    get 'proposal', to: 'static_pages#proposal'
    post 'basket/:order_item_id' => 'orders#change_item_quantity', :as => 'adjust_basket_item_quantity'
    delete 'basket/:order_item_id' => 'orders#change_item_quantity'
    delete 'basket/delete/:order_item_id' => 'orders#remove_item', :as => 'remove_basket_item'
    patch 'send_confirm_order', to: 'orders#confirm_order', as: 'send_confirm_order'
  end
  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }, via: [:get, :post]
  match '', to: redirect("/#{I18n.locale}"), via: [:get, :post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
