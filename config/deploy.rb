require 'bundler/capistrano'

set :application, 'dtv'
set :repository,  'https://github.com/martinvega/dtv.git'
set :deploy_to, '/home/rails_apps/dtv'
set :user, 'multisat'
set :group_writable, false
set :shared_children, %w(system log pids private public config)
set :use_sudo, false

set :scm, :git
set :branch, 'master'
set :deploy_via, :remote_cache

role :web, '174.34.224.21/home/multisat'
role :app, '174.34.224.21/home/multisat'
role :db,  '174.34.224.21/home/multisat', :primary => true


