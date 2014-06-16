#requrire bundler's capistrano tasks to automate gem installation during deployment
require "bundler/capistrano"

#itegration for capistrano with rvm
$:.unshift("./vendor/lib")     # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.3'   # Or whatever env you want it to run in.
#end integration

set :application, "gira"

set :deploy_to, "/opt/app"
set :user, "web"
set :ssh_options, { :forward_agent => true }

set :scm, :git
#set :deploy_via, :remote_cache
set :repository,  "git@github.com:sohara/gira.info.git"
set :branch, "master"
set :rails_env, "production"

set :git_enable_submodules, 1

set :keep_releases, 6
after "deploy:update", "deploy:cleanup"

set :use_sudo, false


role :web, "162.243.43.236"
role :app, "162.243.43.236"
role :db,  "162.243.43.236", :primary => true

desc "Create the symlink to the database.yml in /shared"
task :db_sym_link, :roles => :app do
    run "ln -s #{deploy_to}/shared/database.yml #{current_release}/config/database.yml"
end

# links both /uploads (bcms default) and /public/uploads (for paperlcip)
# to /shared dir
task :link_shared_directories do
  run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
  run "ln -s #{shared_path}/uploads #{release_path}/uploads"
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

after 'deploy:update_code', :db_sym_link, :link_shared_directories
