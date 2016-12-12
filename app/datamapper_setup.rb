require 'data_mapper'
require 'dm-postgres-adapter'
require_relative './models/user'
require_relative './models/listing'

def setup
  DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
  DataMapper.finalize
  DataMapper.auto_upgrade!
end
