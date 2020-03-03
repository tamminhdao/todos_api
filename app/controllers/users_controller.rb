require 'sinatra/json'
require 'json'
require_relative '../todos'

class UsersController < ApplicationController
  include Authentication
  use JwtMiddleware

  post '/signup' do
    params = JSON.parse(request.body.read)
    username = params['username']
    password = params['password']

    unless username && password
      status 422
      return json('error': 'Username and password must be provided')
    end

    begin
      user = User.create!(
        username: username,
        password: digest_password(password)
      )
    rescue ActiveRecord::RecordInvalid => e
      status 409
      return json('error': "Username #{username} already taken")
    end

    status 201
    return json(
      access_token: access_token(username),
      refresh_token: refresh_token(username)
    )
  end

  post '/login' do
    params = JSON.parse(request.body.read)
    username = params['username']
    password = params['password']
    user = User.find_by(username: username)

    unless user && check_password(user.password, password)
      status 401
      return json('error': 'Invalid username or password')
    end

    status 200
    return json(
      access_token: access_token(username),
      refresh_token: refresh_token(username)
    )
  end

  get '/me' do
    username = request.env[:username]
    user = User.find_by(username: username)

    status 200
    return json(
      user: {
        username: username
      }
    )
  end
end
