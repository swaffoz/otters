namespace :deploy do
  desc 'Makes sure local git is in sync with remote.'
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts 'WARNING: HEAD is not the same as origin/master'
      puts 'Run `git push` to sync changes.'
      exit
    end
  end
  
  desc 'Refresh the sitemap of the site'
  task :refresh_sitemap do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, 'sitemap:refresh'
        end
      end
    end
  end
end
