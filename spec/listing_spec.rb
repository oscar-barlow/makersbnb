require_relative '../app/models/listing.rb'

describe Listing do

  let(:unavailable_date) {double :unavailable_date}

  it "Will not be created as an object in the database if a name is not included" do
    expect{Listing.create(name: nil)}.to_not change(Listing, :count)
  end

  it "Will not be created as an object in the database if a price is not included" do
    expect{Listing.create(name: "A Lovely Cottage", price: nil)}.to_not change(Listing, :count)
  end

  it "Will not be created as an object in the database if a description is not included" do
    expect{Listing.create(name: "A Lovely Cottage", price: 12.5, description: nil)}.to_not change(Listing, :count)
  end

end
