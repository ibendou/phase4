Rails.application.routes.draw do
  
  get 'welcome/index'
  resources :jobs
  resources :shift_jobs
  resources :shifts
  resources :store_flavors
  resources :flavors
  resources :assignments
  resources :stores
  resources :employees
  root 'welcome#index'
  get "active", to: "employees#active", as: :employee_active
  get "inactive", to: "employees#inactive", as: :employee_inactive
  
  get "active_", to: "stores#active", as: :store_active
  get "inactive_", to: "stores#inactive", as: :store_inactive
  
  get "current", to: "assignments#current", as: :assignment_current
  get "past", to: "assignments#past", as: :assignment_past
  
  get "active1", to: "flavors#active", as: :flavor_active
  get "inactive1", to: "flavors#inactive", as: :flavor_inactive
end
