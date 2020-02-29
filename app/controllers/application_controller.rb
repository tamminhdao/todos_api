require 'sinatra/base'
require "sinatra/activerecord"

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end
