Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :admin do
    devise_for :admin
  end

  scope module: :publics do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'customers' => 'customers#show'
    get 'customers/edit' => 'customers#edit'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    get 'orders/thanks' => 'orders#thanks'
    post 'orders/confirm' => 'orders#confirm'
    resources :orders, only:[:index, :new, :show, :create]
    resources :addresses, except:[:show, :new]
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
  end

  devise_for :customers, controllers: {
    registrations: 'publics/registrations',
    sessions: "publics/sessions",
  }

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, except:[:destroy]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
  end
end
