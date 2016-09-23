require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/unicorn'

# Confs do servidor de deploy
set :application,   'app_rh'
set :deploy_to,     "/var/www/#{application}"
set :domain,        '192.168.1.13'
set :user,          'ubuntu'
set :forward_agent, true
set :port,          '22'
set :shared_paths,  %w{ log tmp/sockets tmp/pids config/database.yml config/secrets.yml }

# Confs do git
set :repository,  'git@github.com:rodrigovdb/curso-rails.git'
set :branch,      'master'

# Confs do ambiente
set :ruby_version,    '2.3.0'
set :rails_env,       'production'
set :unicorn_config,  'config/unicorn.rb'

# Esta task determina como será o ambiente ao executar tarefas do setup
task :setup_environment do
end

# Esta task determina como será o ambiente ao executar demais tarefas
task :environment do
  invoke :"rvm:use[#{ruby_version}@default]"
end

# Rotinas para configurar o servidor de deploy.
task setup: :setup_environment do
  invoke :'create_deploy_dirs'
  invoke :'install_dependencies'
  invoke :'install_rvm'
end

# Rotinas para realizar o deploy propriamente dito.
desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'unicorn:restart'
    end
  end
end

############################
#     Métodos auxiliares   #
############################

# Cria os diretórios requiridos para fazer o deploy
task create_deploy_dirs: :setup_environment do
  dirs  = %w{log config tmp/sockets tmp/pids}

  dirs.each do |dir|
    path  = "#{deploy_to}/#{shared_path}/#{dir}"
    queue! %[mkdir -p #{path}]
    queue! %[chmod g+rx,u+rwx #{path}]
  end
end

# Instala as dependencias do sistema operacional no servidor de deploy.
task install_dependencies: :setup_environment do
  queue! %[sudo apt-get install git nodejs npm nginx build-essential libxml2 libxml2-dev libxslt-dev libmysqlclient-dev -y]
end

# Instala o RVM de acordo com as recomendações do rvm.io
task install_rvm: :setup_environment do
  rvm_path  = "/home/#{user}/.rvm/bin/rvm"
  queue! %[gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3]
  queue! %[curl -sSL https://get.rvm.io | bash -s stable]
  queue! %[#{rvm_path} reload]
  queue! %[echo "export rvm_max_time_flag=20" >> ~/.rvmrc]
  queue! %[#{rvm_path} install #{ruby_version}]
  queue! %[#{rvm_path} all do gem install bundle]
end
