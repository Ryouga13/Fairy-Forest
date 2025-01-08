Rails.application.routes.draw do
  
  devise_for :users
  
  root to: 'homes#top'
  #get '/' => 'homes#top'
  get 'top' => 'homes#top', as: 'top'
  get 'about' => 'homes#about', as: 'about'
  
  resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    collection do
      get 'search' => 'users#search', as: 'search'
      get 'mypage' => 'users#mypage', as: 'mypage'
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
