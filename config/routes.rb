Rails3Base::Application.routes.draw do
  devise_for :users
  resources :repositories
  root to: 'repositories#new'
end
