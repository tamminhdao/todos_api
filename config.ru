require 'dotenv'
Dotenv.load('./.env.development') if ENV['RACK_ENV'] == 'development'

Dir['./app/controllers/*.rb'].each { |f| require f }

map('/users') { run UsersController }
