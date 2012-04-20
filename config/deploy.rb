require 'bundler/capistrano'

set :application, 'dtv'
set :repository,  'https://github.com/martinvega/dtv.git'
set :deploy_to, '/var/rails/dtv'
set :user, 'deployer'
set :group_writable, false
set :shared_children, %w(system log pids private public config)
set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = "publickey"
ssh_options[:keys] = "#{ENV['HOME']}/.ssh/last_key_ec2.pem"
ssh_options[:config]=false

set :scm, :git
set :branch, 'master'
set :deploy_via, :remote_cache

role :web, '23.21.68.171'
role :app, '23.21.68.171'
role :db,  '23.21.68.171', :primary => true

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end