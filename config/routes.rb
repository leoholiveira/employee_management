Rails.application.routes.draw do
  resources :employees, only: [ :index ]
  root "employees#index"
end