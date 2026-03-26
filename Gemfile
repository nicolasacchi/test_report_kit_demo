source "https://rubygems.org"

gem "rails", "~> 8.1.3"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "rspec-rails", "~> 7.0"
  gem "factory_bot_rails"
end

group :test do
  gem "test_report_kit", github: "nicolasacchi/test_report_kit", branch: "main"
  gem "simplecov", require: false
  gem "simplecov-json", require: false
  gem "test-prof", "~> 1.0"
end

# coverage viewer
# syntax fix
# ux
# perf
# factory
# resource
# eventprof fix
