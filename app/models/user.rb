require 'dm-validations'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :username, Text
  property :email, String
  property :password_digest, Text

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
