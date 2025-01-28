Rails.application.routes.draw do
  
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  devise_scope :user do
    post "users/guest_sign_in" => "user/sessions#guest_sign_in"
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: 'homes#top'
  #get '/' => 'homes#top'
  get 'top' => 'homes#top', as: 'top'
  get 'about' => 'homes#about', as: 'about'
  get 'account' => 'homes#account', as: 'account'
  get 'search' => 'searches#search'
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search' => 'posts#search'
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
    collection do
      get 'search' => 'users#search'
      get 'mypage' => 'users#mypage'
    end
    member do
      get 'check' => 'users#check'
      patch 'withdrawal' => 'users#withdrawal'
    end
  end

  namespace :admin do
    get 'top' => 'homes#top'
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
    resources :users do
      member do
        patch 'withdrawal' => 'users#withdrawal'
        patch 'reactivate' => 'users#reactivate'
      end
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
