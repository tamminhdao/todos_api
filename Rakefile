require "sinatra/activerecord"
require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    Dir['./app/models/*.rb'].each { |f| require f }
  end
end
