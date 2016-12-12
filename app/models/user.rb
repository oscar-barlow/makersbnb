require_relative "datamapper_setup"
require 'dm-validations'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :username, Text
  property :email, String
  property :password_digest, Text

  attr_reader :password
  attr_accessor :confirmation_password

  def password=(password)
    @password = password
    
  end
end

setup
