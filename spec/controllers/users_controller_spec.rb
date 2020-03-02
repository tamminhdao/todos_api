require 'spec_helper'
require 'rack/test'

RSpec.describe UsersController do
  include Rack::Test::Methods

  def app
    UsersController.new
  end

  context 'POST /signup' do
    let(:params) do
      {
        username: 'test_user',
        password: '123pass'
      }
    end

    it 'signs up a new user' do
      # GIVEN valid signup information
      # WHEN new signup request is submitted
      # THEN server  returns http status code 201 (Created)

      post '/signup', params.to_json

      expect(last_response.status).to eq(201)
      expect(last_response.body).to eq({ user: { username: 'test_user' } }.to_json)
    end

    it 'does not create user with incomplete infomation' do
      # GIVEN incomplete signup information
      # WHEN new signup request is submitted
      # THEN server returns http status code 422 (Unprocessable Entity) and error message in json response

      post '/signup', {}.to_json

      expect(last_response.status).to eq(422)
      expect(last_response.body).to include('Username and password must be provided')
    end

    it 'does not create user with duplicated username' do
      # GIVEN an username already in use
      # WHEN new signup request is submitted using the existing username
      # THEN server returns http status code 409 (Conflict) and error message in json response

      post '/signup', params.to_json
      post '/signup', params.to_json

      expect(last_response.status).to eq(409)
      expect(last_response.body).to include('Username test_user already taken')
    end
  end
end
