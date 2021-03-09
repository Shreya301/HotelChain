Rails.application.routes.draw do
  devise_for :admins
  resources :supervisors
  resources :service_staffs
  resources :rooms
  resources :monthly_expenses
  resources :members
  resources :guests
  resources :employees
  resources :hotels
  root 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
