require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :application,   'app_rh'
set :deploy_to,     "/var/www/#{applicaiton}"
set :domain,        '192.168.1.13'
set :user,          'ubuntu'
set :forward_agent, true
set :port,          '22'
set :shared_paths,  %w{ log tmp/sockets tmp/pids config/database.yml config/secrets.yml }

set :branch,      'master'
set :repository,  'git@github.com:rodrigovdb/curso-rails.git'

set :ruby_version, '2.3.0'

set :unicorn_config,  'config/unicorn.rb'
set :unicorn_env,     'production'
set :rails_env,       'production'

task :environment do
  invoke :"rvm:use[#{ruby_version}@default]"
end

task :setup_environment do
end

task setup: :setup_environment do
  invoke :'create_deploy_dirs'
  invoke :'install_dependencies'
  invoke :'install_rvm'
  invoke :'configure_nginx'
end

desc "Deploys the current version to the server."
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
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
#     Auxiliar methods     #
############################

# Create all required dirs on deploy dir
task create_deploy_dirs: :setup_environment do
  dirs  = %w{log config tmp/sockets tmp/pids}

  dirs.each do |dir|
    path  = "#{deploy_to}/#{shared_path}/#{dir}"
    queue! %[mkdir -p #{path}]
    queue! %[chmod g+rx,u+rwx #{path}]
  end
end

# Install OS dependencies. Initially thinked to setup.
task install_dependencies: :setup_environment do
  # queue! %[sudo apt-get install git nodejs npm nginx build-essential libxml2 libxml2-dev libxslt-dev libmysqlclient-dev -y]
  queue! %[sudo apt-get install git nodejs npm nginx build-essential libxml2 libxml2-dev libxslt-dev -y]
end

# Install RVM from rvm.io recomendations
task install_rvm: :setup_environment do
  rvm_path  = "/home/#{user}/.rvm/bin/rvm"
  queue! %[gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3]
  queue! %[curl -sSL https://get.rvm.io | bash -s stable]
  queue! %[#{rvm_path} reload]
  queue! %[echo "export rvm_max_time_flag=20" >> ~/.rvmrc]
  queue! %[#{rvm_path} install #{ruby_version}]
  queue! %[#{rvm_path} all do gem install bundle]
end


