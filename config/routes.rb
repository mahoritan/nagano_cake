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
    patch 'customers' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    resources :addresses, except:[:show, :new]
    resources :items, only:[:index, :show]
  end

  devise_for :customers, controllers: {
    registrations: 'publics/registrations',
    sessions: "publics/sessions",
  }

  namespace :admin do
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, except:[:destroy]
    resources :customers, only:[:index, :show, :edit, :update]
  end
end
