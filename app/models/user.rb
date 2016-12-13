require 'dm-validations'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :username, Text, required: true, unique: true
  property :email, String, required: true, unique: true
  property :password_digest, Text, required: true

  has n, :listings

  attr_reader :password

  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_format_of :email, as: :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def self.authenticate(username, password)
    user = first(username: username)
      if user && BCrypt::Password.new(user.password_digest) == password
        user
      else
        nil
      end
  end

end
