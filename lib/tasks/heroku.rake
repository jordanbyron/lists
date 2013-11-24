namespace :heroku do
  desc 'Keep the production app warm'
  task :warm do
    `curl www.schedulemaps.com`
  end
end
