Rails.application.routes.draw do


  devise_for :admin
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :publics do
    devise_for :customers
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end

  namespace :admin do
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, except:[:destroy]
    resources :customers, only:[:index, :show, :edit, :update]
  end
end
