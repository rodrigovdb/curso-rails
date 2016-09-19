Rails.application.routes.draw do
  devise_for :users, path: ''
  resources :employees, path: 'colaboradores' do
    resources :contacts, path: 'contatos', path_names: { new: 'cadastrar', edit: 'editar' }
  end
  #resources :employees, path: 'colaboradores', path_names: { new: 'cadastrar', edit: 'editar' } do
  #  resources :contacts, path: 'contatos', path_names: { new: 'cadastrar', edit: 'editar' }
  #end

  get 'welcome/index'

  root 'welcome#index'
end
