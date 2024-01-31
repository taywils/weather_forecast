# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# view_component is a framework for building reusable, testable & encapsulated view components in Ruby on Rails.
# GitHub: https://github.com/github/view_component
gem 'view_component'

# dry-initializer is a simple mixin to define your object's attributes as a set of dry-types.
# GitHub: https://github.com/dry-rb/dry-initializer
gem 'dry-initializer'

# dry-types is a flexible type system with a focus on explicitness, clarity and precision.
# GitHub: https://github.com/dry-rb/dry-types
gem 'dry-types'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ]

  # factory_bot_rails is a fixtures replacement with a straightforward definition syntax
  # GitHub: https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails'

  # rspec-rails is a testing framework for Rails 3.x, 4.x and 5.x
  # GitHub: https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 6.0.0'

  # rubocop-capybara is a RuboCop extension focused on enforcing Capybara best practices
  # GitHub: https://github.com/rubocop/rubocop-capybara
  gem 'rubocop-capybara', require: false

  # rubocop-factory_bot is a RuboCop extension focused on enforcing FactoryBot best practices
  # GitHub: https://github.com/rubocop/rubocop-factory_bot
  gem 'rubocop-factory_bot', require: false

  # rubocop-performance is a RuboCop extension focused on enforcing performance best practices
  # GitHub: https://github.com/rubocop/rubocop-performance
  gem 'rubocop-performance', require: false

  # rubocop-rails is a RuboCop extension focused on enforcing Rails best practices
  # GitHub: https://github.com/rubocop/rubocop-rails
  gem 'rubocop-rails', require: false

  # rubocop-rspec is a RuboCop extension focused on enforcing RSpec best practices
  # GitHub: https://github.com/rubocop/rubocop-rspec
  gem 'rubocop-rspec', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # annotate is a gem that adds a comment summarizing the current schema to the top or bottom of each of
  # your ActiveRecord models, fixtures, factories etc.
  # GitHub: https://github.com/ctran/annotate_models
  gem 'annotate'

  # solargraph is a language server that provides intellisense, code completion, and inline documentation for Ruby.
  # GitHub: https://github.com/castwide/solargraph
  gem 'solargraph'

  # hotwire-livereload is a gem that provides live reloading functionality for Rails applications using Hotwire.
  # GitHub: https://github.com/julianrubisch/hotwire-livereload
  gem 'hotwire-livereload'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'

  # cuprite is a pure Ruby driver (read as no Selenium/WebDriver/ChromeDriver) for Capybara.
  # GitHub: https://github.com/rubycdp/cuprite
  gem 'cuprite'

  # simplecov is a code coverage analysis tool for Ruby. It uses Ruby's built-in Coverage library
  # to gather code coverage data, but makes processing its results much easier by providing
  # a clean API to filter, group, merge, format, and display those results.
  # GitHub: https://github.com/simplecov-ruby/simplecov
  gem 'simplecov', require: false
end
