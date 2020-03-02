require 'bcrypt'

module Authentication
  def digest_password(password)
    BCrypt::Password.create(password)
  end

  def check_password(hash, password)
    BCrypt::Password.new(hash) == password
  end
end
