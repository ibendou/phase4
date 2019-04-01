Rails.application.routes.draw do
  get 'welcome/index'
  resources :assignments
  resources :stores
  resources :employees
  root 'welcome#index'
  get "active" , to: "employees#active" , as: :employee_active
  get "inactive" , to: "employees#inactive" , as: :employee_inactive
  
  get "active_" , to: "stores#active" , as: :store_active
  get "inactive_" , to: "stores#inactive" , as: :store_inactive
end
