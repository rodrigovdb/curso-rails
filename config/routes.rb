Rails.application.routes.draw do
  get   '/colaboradores',           to: 'employees#index',  as: :employees
  get   '/colaboradores/cadastrar', to: 'employees#new',    as: :new_employee
  get   '/colaboradores/:id',       to: 'employees#show',   as: :employee
  post  '/colaboradores',           to: 'employees#create'

  get 'welcome/index'

  root 'welcome#index'
end
