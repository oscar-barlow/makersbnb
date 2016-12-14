require 'data_mapper'
require 'dm-postgres-adapter'

class Booking

  include DataMapper::Resource

  property :id, Serial
  property :check_in, Date, required: true
  property :message, Text

  belongs_to :user
  belongs_to :listing
end
