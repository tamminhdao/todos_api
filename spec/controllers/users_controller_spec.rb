require 'spec_helper'
require 'rack/test'
require 'bcrypt'

RSpec.describe UsersController do
  include Rack::Test::Methods
  include BCrypt

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
      it 'responses with a 404 and an error message' do
        post '/login', params.to_json

        expect(last_response.status).to eq(401)
        expect(last_response.body).to include('Invalid username or password')
      end
    end

    context 'when logging in with the wrong password' do
      let!(:user) { User.create!(username: 'user_one', password: wrong_password) }

      it 'responses with a 404 and an error message' do
        post '/login', params.to_json

        expect(last_response.status).to eq(401)
        expect(last_response.body).to include('Invalid username or password')
      end
    end

    context 'when logging in a valid user' do
      let!(:user) { User.create!(username: 'user_one', password: password_digest) }

      it 'responses with a 200 and the validated user' do
        post '/login', params.to_json

        expect(last_response.status).to eq(200)
      end
    end
  end
end
