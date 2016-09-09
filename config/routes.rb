Rails.application.routes.draw do
  resources :employees, path: 'colaboradores'

  get 'welcome/index'

  root 'welcome#index'
end
