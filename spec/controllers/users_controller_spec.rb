require 'spec_helper'
require 'rack/test'

RSpec.describe UsersController do
  include Rack::Test::Methods

  def app
    UsersController.new
  end

  it "signs up a new user" do
    get '/signup'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Signup')
  end
end
