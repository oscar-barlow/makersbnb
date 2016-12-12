require_relative '../app/models/listing.rb'

describe Listing do

  it "can be created as an object in the database" do
    expect{Listing.create(name: "A Lovely Cottage")}.to change(Listing, :count).by(1)
  end


end
