Rails.application.routes.draw do
  
  devise_for :users
  
  root to: 'homes#top'
  #get '/' => 'homes#top'
  get 'top' => 'homes#top', as: 'top'
  get 'about' => 'homes#about', as: 'about'
  get 'search' => 'searches#search'
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
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


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
