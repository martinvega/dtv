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

role :web, 'multisat.com.ar'
role :app, 'multisat.com.ar'
role :db,  'multisat.com.ar', :primary => true


