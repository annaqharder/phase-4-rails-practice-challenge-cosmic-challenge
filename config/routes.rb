Rails.application.routes.draw do
  resources :missions, only: [:create]
  resources :planets, only: [:index]
  resources :scientists
end
