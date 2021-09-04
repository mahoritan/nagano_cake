Rails.application.routes.draw do

  devise_for :admin
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, except:[:destroy]
  end
end
