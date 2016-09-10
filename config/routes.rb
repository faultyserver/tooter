Rails.application.routes.draw do
  resources :users, :toots

  root to: 'toots#index'
end
