# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'gzhack-site'
set :repo_url, 'git@github.com:gzhack/gzhack-site.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "~/gzhack-site"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml db/production.sqlite3}

# Default value for linked_dirs is []
set :linked_dirs, %w{tmp/pids public/uploads}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 10

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :log_revision, :open_site do
    run_locally do
      `open http://www.gzhack.io`
    end
  end

end

# 初次部署流程
# 1. 执行环境检查跟准备必要文件夹等
#
#   $ cap production deploy:check
#
#   这个过程可能会遇到如下错误：
#   ERROR linked file /var/www/gzhack-site/shared/config/database.yml does not exist on xxx.com
#   可以先上服务器手工创建 /var/www/gzhack-site/shared/config/database.yml 文件并且编写配置。最后重新执行此命令。

# 2. 执行部署（日常部署也是只需要此操作）
#
#   $ cap production deploy
#
#   ~~~~~~~~~ 可能很快也可能很漫长的部署过程，会 bundle，会 precompile assets，会 migrate database ~~~~~~~
#
