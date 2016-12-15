require 'data_mapper'
require 'dm-postgres-adapter'

class Listing

  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :price, Float, required: true
  property :description, String, required: true

  has n, :bookings, through: Resource
  has n, :unavailables, through: Resource
  belongs_to :user

  def set_unavailable_date
  end

end
