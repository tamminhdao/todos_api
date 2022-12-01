source 'https://rubygems.org'

ruby '2.6.3'

gem 'bcrypt', '~> 3.1.13'
gem 'dotenv', '~> 2.7.5'
gem 'json', '2.3.0'
gem 'jwt', '~> 1.5.4'
gem 'pg', '~> 1.2', '>= 1.2.2'
gem 'rack', '~> 2.2'
gem 'rack-test', '~> 2.0'
gem 'rake'
gem 'rspec', '~> 3.9'
gem 'sinatra', '~> 3.0'
gem 'sinatra-activerecord', '~> 2.0', '>= 2.0.14'
gem 'sinatra-contrib', '~> 3.0'

group :development do
  gem 'guard-rspec', '4.7.3'
  gem 'rubocop', '~> 0.71.0', require: false
end

group :test, :development do
  gem 'pry', '~> 0.12.2'
end

group :test do
  gem 'database_cleaner-active_record'
end
