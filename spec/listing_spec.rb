require_relative '../app/models/listing.rb'

describe Listing do

  let!(:listing) do
    Listing.create(name: "A Lovely Cottage", price: 12.5, description: "Includes jacuzzi")
  end

  it "Can be created as an object in the database" do
    expect{Listing.create(name: "A Lovely Cottage")}.to change(Listing, :count).by(1)
  end

  it "Will not be created as an object in the database if a name is not included" do
    expect{Listing.create(name: nil)}.to_not change(Listing, :count)
  end

end
