require 'data_mapper'
require 'dm-postgres-adapter'

class Unavailable

  include DataMapper::Resource

  property :id, Serial
  property :date, Date

  belongs_to :listing

end
