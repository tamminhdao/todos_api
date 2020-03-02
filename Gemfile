source 'https://rubygems.org'

ruby '2.6.3'

gem 'bcrypt', '~> 3.1.13'
gem 'json', '2.3.0'
gem 'pg', '~> 1.2', '>= 1.2.2'
gem 'rack', '~> 2.0'
gem 'rack-test', '~> 1.1'
gem 'rake'
gem 'rspec', '~> 3.9'
gem 'sinatra', '~> 2.0', '>= 2.0.8.1'
gem 'sinatra-activerecord', '~> 2.0', '>= 2.0.14'
gem 'sinatra-contrib', '~> 2.0', '>= 2.0.8.1'

group :development do
  gem 'rubocop', '~> 0.71.0', require: false
  gem 'guard-rspec', '4.7.3'
end

group :test, :development do
  gem 'pry', '~> 0.12.2'
end

group :test do
  gem 'database_cleaner-active_record'
end
