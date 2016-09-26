Rails.application.routes.draw do
  devise_for :users,  path: 'usuarios',
                      path_names: {
                        sign_in: 'entrar',
                        sign_out: 'sair',
                        password: 'senha',
                        new_user_password: '',
                        confirmation: 'confirmacao',
                        sign_up: 'cadastrar'
                      }

  get '/colaboradores/enviar-por-email', to: 'employees#send_by_mail', as: :employees_emailer
  resources :employees, path: 'colaboradores', path_names: { new: 'cadastrar', edit: 'editar' } do
    resources :contacts, path: 'contatos', path_names: { new: 'cadastrar', edit: 'editar' }
  end

  get 'welcome/index'

  root 'welcome#index'
end
