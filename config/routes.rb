Rails.application.routes.draw do
  resources :users, :toots

  get   '/signup' => 'users#new', as: :sign_up

  # Session management
  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#create'
  get   '/logout' => 'sessions#destroy'


  # Toot favoriting
  post  '/toots/:id/favorite'   => 'favorites#create',  as: :favorite
  post  '/toots/:id/unfavorite' => 'favorites#destroy', as: :unfavorite

  # User following
  post  '/users/:id/follow'     => 'follows#create',  as: :follow
  post  '/users/:id/unfollow'     => 'follows#destroy', as: :unfollow


  # Action rendered at '/'
  root to: 'toots#index'
end
