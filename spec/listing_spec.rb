require_relative '../app/models/listing.rb'

describe Listing do

  let!(:listing) do
    Listing.create(name: "A Lovely Cottage", price: 12.5)
  end

  it "can be created as an object in the database" do
    expect{Listing.create(name: "A Lovely Cottage")}.to change(Listing, :count).by(1)
  end




end
