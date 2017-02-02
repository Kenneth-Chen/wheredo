source 'https://rubygems.org'

# Rails
gem 'rails', '4.2.5.1'
gem 'haml'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

# Data
gem 'pg'
gem 'redis-namespace'

# Ops
gem 'unicorn-rails'

# General
gem 'phony'

# Auth
gem 'devise', '~> 4.2.0'

# Async
gem 'sidekiq', '~> 4.2.1'
gem "sidekiq-cron", "~> 0.4.0"

group :production, :staging do
  gem "rails_12factor"
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'letter_opener'
  gem 'spring'
end

