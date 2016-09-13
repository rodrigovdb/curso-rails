Rails.application.routes.draw do
  resources :employees, path: 'colaboradores' do
    resources :contacts, path: 'contatos', path_names: { new: 'cadastrar', edit: 'editar' }
  end

  get 'welcome/index'

  root 'welcome#index'
end
