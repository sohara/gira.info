#requrire bundler's capistrano tasks to automate gem installation during deployment
require "bundler/capistrano"

#itegration for capistrano with rvm
set :rvm_type, :user                      # we have RVM in home dir, not system-wide install
$:.unshift("#{ENV["HOME"]}/.rvm/lib")     # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.8.7'   # Or whatever env you want it to run in.
#end integration

set :application, "gira"

set :deploy_to, "/var/vhosts/gira.info/#{application}"
set :user, "alien8web"
set :ssh_options, { :forward_agent => true }

set :scm, :git
#set :deploy_via, :remote_cache
set :repository, "file:///opt/repos/gira.git"
set :local_repository, "alien8web:/opt/repos/gira.git"
set :branch, "master"
set :rails_env, "production"

set :git_enable_submodules, 1

set :keep_releases, 6
after "deploy:update", "deploy:cleanup"

set :use_sudo, false


role :web, "184.107.185.178"
role :app, "184.107.185.178"
role :db,  "184.107.185.178", :primary => true


desc "Create the symlink to the database.yml in /shared"
task :db_sym_link, :roles => :app do
    run "ln -s /var/vhosts/gira.info/gira/shared/database.yml #{current_release}/config/database.yml"
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

## Tasks to restart passenger standalone
namespace :deploy do
  desc "Start passenger standalone"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec passenger start -a 127.0.0.1 -p 3000 --daemonize --environment production"
  end
  desc "Stop passenger standalone on the server"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec passenger stop"
  end
  desc "Retart passenger standalone"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end


after 'deploy:update_code', :db_sym_link, :link_shared_directories
