source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'feed-normalizer'

group :production do
 gem "therubyracer", :platforms => :ruby
 gem "mysql2", '0.3.13'
end


group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.7'
  gem 'rspec-rails', '~>2.0'
  gem 'tapp'
  gem 'factory_girl_rails'
  gem 'forgery'
  gem 'timecop'
end

group :development do
  gem 'capistrano', '~>2.15.5', :require => false
  gem 'capistrano-ext', :require => false
  gem 'capistrano_colors', :require => false
end

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'rails_admin'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#gem 'feedzirra'
#gem 'activeadmin'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]