require 'sinatra/json'
require 'json'
require_relative '../todos'

class UsersController < ApplicationController
  include Authentication

  post '/signup' do
    params = JSON.parse(request.body.read)

    unless params['username'] && params['password']
      status 422
      return json('error': 'Username and password must be provided')
    end

    begin
      user = User.create!(
        username: params['username'],
        password: digest_password(params['password'])
      )
    rescue ActiveRecord::RecordInvalid => e
      status 409
      return json('error': "Username #{params['username']} already taken")
    end

    status 201
    return json(
      user: {
        username: user.username
      }
    )
  end

  post '/login' do
    params = JSON.parse(request.body.read)
    user = User.find_by(username: params['username'])
    has_correct_password = check_password(user.password, params['password']) if user

    unless user && has_correct_password
      status 401
      return json('error': 'Invalid username or password')
    end

    status 200
  end
end
