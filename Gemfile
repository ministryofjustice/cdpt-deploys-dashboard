source "https://rubygems.org"

ruby file: ".ruby-version"

gem "cssbundling-rails", "~> 1.4"
gem "govuk-components", ">= 6.5.0"
gem "govuk_design_system_formbuilder", ">= 6.5.0"
gem "httparty"
gem "jsbundling-rails", "~> 1.3"
gem "pg"
gem "propshaft"
gem "puma", ">= 8.0.2"
gem "rails", "~> 8.1.4.1"
gem "sqlite3", ">= 2.1"

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue", ">= 1.7.1"

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "rspec-rails", ">= 8.0.5"
  gem "rubocop-govuk", ">= 6.0.0", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver", ">= 4.44.0"
  gem "webmock"
end
