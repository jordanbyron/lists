source 'http://rubygems.org'

gem 'rails', '~> 3.1.2'

gem 'pg'

# omniauth

gem 'omniauth-twitter'
#gem 'omniauth-identity'
#gem 'omniauth-facebook'
#gem 'omniauth', '~> 1.0.1'

gem 'haml'
gem 'sass'
gem 'will_paginate', '~> 3.0'
gem 'cocoon'
gem 'jquery-rails'

group :assets do
  gem 'sass-rails',   '~> 3.1.5.rc.2'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'compass',      '~> 0.12.alpha'
end

# Deploy with Capistrano
# gem 'capistrano'

group 'test' do
  gem 'minitest',           '~> 2.8.1'
  gem 'capybara',           '~> 1.1.1'
  gem 'factory_girl_rails'
  gem 'colorific',          '~> 1.0.0'
  gem 'test_notifier'       , '~> 1.0.0'
end

group :production do
  gem 'therubyracer'
end