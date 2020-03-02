class User < ActiveRecord::Base
  validates :username, uniqueness: true
end
