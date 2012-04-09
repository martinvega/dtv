require 'bundler/capistrano'

set :application, 'dtv'
set :repository,  'https://github.com/martinvega/dtv.git'
set :deploy_to, '/var/rails/dtv'
set :user, 'ubuntu'
set :group_writable, false
set :shared_children, %w(system log pids private public config)
set :use_sudo, false

set :scm, :git
set :branch, 'master'
set :deploy_via, :remote_cache

role :web, 'ec2-107-21-82-13.compute-1.amazonaws.com'
role :app, 'ec2-107-21-82-13.compute-1.amazonaws.com'
role :db,  'ec2-107-21-82-13.compute-1.amazonaws.com', :primary => true


