require 'data_mapper'
require 'dm-postgres-adapter'

class Listing

  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :price, Decimal
  property :description, String

end
