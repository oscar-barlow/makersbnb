require 'data_mapper'
require 'dm-postgres-adapter'

class Listing

  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :price, Float, required: true
  property :description, String, required: true

  belongs_to :user

end
