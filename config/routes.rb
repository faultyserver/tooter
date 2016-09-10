Rails.application.routes.draw do
  resources :users, :toots

  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#create'
  get   '/logout' => 'sessions#destroy'

  root to: 'toots#index'
end
