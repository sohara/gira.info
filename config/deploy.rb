set :application, "gira"

set :deploy_to, "/var/vhosts/gira.info/#{application}"
set :user, "alien8web" 
set :ssh_options, { :forward_agent => true }

set :scm, :git
set :deploy_via, :remote_cache
set :repository, "file:///opt/repos/gira.git"
set :branch, "master"

set :git_enable_submodules, 1

set :keep_releases, 6
after "deploy:update", "deploy:cleanup"

set :use_sudo, false


role :web, "209.172.35.182"
role :app, "209.172.35.182"
role :db,  "209.172.35.182", :primary => true


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

after 'deploy:update_code', :db_sym_link, :link_shared_directories