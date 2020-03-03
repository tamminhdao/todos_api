require 'spec_helper'
require 'rack/test'
require 'bcrypt'

RSpec.describe UsersController do
  include Rack::Test::Methods
  include BCrypt
  include Authentication

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
      # THEN server  returns http status code 201 (Created) and valid JWT tokens in json response

      post '/signup', params.to_json

      json_response = JSON.parse(last_response.body)

      expect(last_response.status).to eq(201)
      expect(json_response['access_token']).to_not be_nil
      expect(json_response['refresh_token']).to_not be_nil
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

  context 'POST /login' do
    let(:password_digest) { BCrypt::Password.create('mypass') }
    let(:wrong_password) { BCrypt::Password.create('wrongpass') }
    let(:params) do
      {
        username: 'user_one',
        password: 'mypass'
      }
    end

    context 'when a user does not exist' do
      it 'responses with a 401 and an error message' do
        post '/login', params.to_json

        expect(last_response.status).to eq(401)
        expect(last_response.body).to include('Invalid username or password')
      end
    end

    context 'when logging in with the wrong password' do
      let!(:user) { User.create!(username: 'user_one', password: wrong_password) }

      it 'responses with a 401 and an error message' do
        post '/login', params.to_json

        expect(last_response.status).to eq(401)
        expect(last_response.body).to include('Invalid username or password')
      end
    end

    context 'when logging in a valid user' do
      let!(:user) { User.create!(username: 'user_one', password: password_digest) }

      it 'responses with a 200 and the validated user' do
        post '/login', params.to_json

        json_response = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(json_response['access_token']).to_not be_nil
        expect(json_response['refresh_token']).to_not be_nil
      end
    end
  end

  context 'GET /me' do
    let(:params) do
      {
        username: 'current_user',
        password: 'current_pass'
      }
    end
    let(:encoded_jwt) { access_token('current_user') }

    before(:each) do
      post '/login', params.to_json
    end

    it 'returns the current user information' do
      get '/me', nil, 'HTTP_AUTHORIZATION' => "Bearer #{encoded_jwt}"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ user: { 'username': 'current_user' } }.to_json)
    end

    context 'when missing authorization header' do
      it 'returns a 401 and error message' do
        get '/me'

        expect(last_response.status).to eq(401)
        expect(last_response.body).to include('A token must be passed')
      end
    end
  end
end
