source "https://rubygems.org"

gem "cssbundling-rails", "~> 1.4"
gem "govuk-components"
gem "govuk_design_system_formbuilder"
gem "httparty"
gem "jsbundling-rails", "~> 1.3"
gem "pg"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rails", "~> 8.1.1"
gem "sqlite3", ">= 2.1"

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "rubocop-govuk", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
