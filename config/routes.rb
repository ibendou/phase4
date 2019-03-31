Rails.application.routes.draw do
  get 'welcome/index'
  resources :assignments
  resources :stores
  resources :employees
  root 'welcome#index'
  
end
