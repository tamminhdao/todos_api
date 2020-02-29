Dir['./app/controllers/*.rb'].each { |f| require f }

map('/users') { run UsersController }
