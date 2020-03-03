require 'dotenv/load'
require 'bcrypt'
require 'jwt'

module Authentication
  def digest_password(password)
    BCrypt::Password.create(password)
  end

  def check_password(hash, password)
    BCrypt::Password.new(hash) == password
  end

  def access_token(username)
    JWT.encode(payload(username), ENV['JWT_SECRET'], 'HS256')
  end

  def refresh_token(username)
    JWT.encode(username, ENV['HMAC_SECRET'], 'HS384')
  end

  private

  def payload(username)
    {
      exp: Time.now.to_i + 60 * 60,
      iat: Time.now.to_i,
      iss: ENV['JWT_ISSUER'],
      user: {
        username: username
      }
    }
  end
end
