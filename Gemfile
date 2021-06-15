source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"

gem "bootsnap", ">= 1.4.4", require: false
gem "bootstrap-sass", "~> 3.4.1"
gem "config"
gem "figaro"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.5.3"
gem "puma", "~> 5.0"
gem "rails", "~> 6.0.3"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "sassc-rails", ">= 2.1.0"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "pry", "~> 0.14.0"
  gem "rspec-rails", "~> 4.0.1"
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :development, :test do
  gem "rails_best_practices"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]