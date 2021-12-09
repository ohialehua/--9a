Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'relationships/index'
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end
  resources :messages, only: [:create, :show]
  resources :groups do
    get 'join' => 'groups#join'
    post 'join' => 'groups#join'
    get 'new/mail' => 'groups#new_mail'
    get 'send/mail' => 'groups#send_mail'
  end
  post 'books/:id' => 'books#show'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
    patch '/book_comments' => 'book_comments#create'
  end
end