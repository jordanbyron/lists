require 'bundler/capistrano'

set :application, "simplegiftlist.com"
set :repository,  "git://github.com/jordanbyron/lists.git"
set :scm, :git
set :user, "byron"
set :deploy_to, "~/#{application}"
set :branch, "master"
set :use_sudo, false
set :deploy_via, :remote_cache
set :bundle_without, [:test]

server "simplegiftlist.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:update_code' do
  { "database.yml"             => "config/database.yml",
    "secret_token.rb"          => "config/initializers/secret_token.rb",
    "mail_settings.rb"         => "config/initializers/mail_settings.rb",
    "omniauth.rb"              => "config/initializers/omniauth.rb" }.
  each do |from, to|
    run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
  end
end

after  "deploy", "deploy:migrate"
after  "deploy", "deploy:cleanup"

load 'deploy/assets'
