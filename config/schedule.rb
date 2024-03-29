# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# set :environment_variable, (ENV['RAILS_ENV'] || 'development')

every 1.minute do
  runner "Product.reset_day_views", :environment => (ENV['RAILS_ENV'] || 'development')
end

every 1.week do
  runner "Product.reset_week_views", :environment => (ENV['RAILS_ENV'] || 'development')
end

every 1.month do
  runner "Product.reset_month_views", :environment => (ENV['RAILS_ENV'] || 'development')
end

every 1.week do
  runner "Newbook.mail_about_newbooks", :environment => (ENV['RAILS_ENV'] || 'development')
end