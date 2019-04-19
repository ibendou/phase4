Rails.application.routes.draw do
  resources :jobs
  resources :shift_jobs
  resources :shifts
  resources :store_flavors
  resources :falvors
  get 'welcome/index'
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
end
