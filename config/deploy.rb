set :application, "optimus"
set :repository,  "https://github.com/shahroon/optimus.git"
server "162.243.69.154", :app, :web, :db, :primary => true
set :user, "root"
set :deploy_to, "/home/rails/#{application}"
#set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, "production"
# Wanna be able to set the 'branch' on the command line, to mention a specific tag?
# While still defaulting to 'master' or any other branch you want? In your deploy.rb:
# set :branch, fetch(:branch, "master")
# cap -S branch=branchname deploy
# set :deploy_via, :remote_cache
namespace :deploy do
  task :symlink_config, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
#after 'deploy:update_code', 'deploy:migrate'
# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end