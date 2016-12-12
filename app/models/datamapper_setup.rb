require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'user'

def setup
  DataMapper.setup(:default, "postgres://makersbnb_#{ENV['RACK_ENV']}")
  DataMapper.finalize
  DataMapper.auto_upgrade!
end
