# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in zarby.gemspec
gemspec

gem "rake", "~> 13.0"

group :development, :test do
  gem 'codecov', '~> 0.6.0'
  gem 'dotenv', '~> 2.8', '>= 2.8.1'
  gem 'rails', '~> 7.1', '>= 7.1.1'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'simplecov', '~> 0.21.2'
  gem 'vcr', '~> 6.2'
end

group :test do
  gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
end
