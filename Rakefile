# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

desc "This task is called by the Heroku scheduler add-on"
  task :fetch_rss_feed => :environment do
  Tasks::FetchRssFeedTask.test()
end

ApiChallenge2::Application.load_tasks
