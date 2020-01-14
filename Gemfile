# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0', '>= 6.0.2.1'
# Use postgres as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server
gem 'puma', '~> 4.3', '>= 4.3.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9', '>= 2.9.1'
# Modern responsive front-end framework based on Material Design
gem 'materialize-sass', '~> 1.0'
# Fantastic icon collection for Rails projects
gem 'material_icons', '~> 2.2', '>= 2.2.1'
# jQuery for Rails
gem 'jquery-rails', '~> 4.3', '>= 4.3.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', '>= 3.1.13'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.4', '>= 1.4.5', require: false

group :development, :test do
  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  # https://github.com/faker-ruby/faker
  gem 'faker', '~> 2.9'
  # http://pryrepl.org/ (call 'binding.pry' anywhere in the code to stop execution and get a debugger console)
  gem 'pry', '~> 0.12.2'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2', '>= 3.2.1'
  gem 'web-console', '~> 4.0', '>= 4.0.1'
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.7', '>= 1.7.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # https://github.com/teamcapybara/capybara
  gem 'capybara', '~> 3.30'
  # https://github.com/mattheworiordan/capybara-screenshot
  gem 'capybara-screenshot', '~> 1.0', '>= 1.0.24'
  # https://github.com/DatabaseCleaner/database_cleaner
  gem 'database_cleaner', '~> 1.7'
  # https://github.com/colszowka/simplecov
  gem 'simplecov', '~> 0.17.1'
  # https://github.com/site-prism/site_prism
  gem 'site_prism', '~> 3.4', '>= 3.4.1'
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.9'
  # https://github.com/rubocop-hq/rubocop-performance
  gem 'rubocop-performance', '~> 1.5', '>= 1.5.1'
  # https://github.com/rubocop-hq/rubocop-rspec
  gem 'rubocop-rspec', '~> 1.37'
  # https://rubygems.org/gems/webdrivers/versions/4.2.0
  gem 'webdrivers', '~> 4.2'
end
