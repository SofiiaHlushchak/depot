# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 7.2.1"

gem "bcrypt", "~> 3.1", ">= 3.1.12"
gem "importmap-rails"
gem "jbuilder"
gem "puma", ">= 5.0"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]

gem "bootsnap", require: false

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "pry"
  gem "rubocop", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
end

gem "image_processing", "~> 1.13"
