require 'spec_helper'
require 'web_helper'

feature "Create listing" do

  before(:each) do
    visit '/user/new'
    sign_up
  end

  scenario "Signed up user creates new listing" do
    create_listing
    expect(page).to have_content("Your Listings")
    expect(page).to have_content("A Lovely Cottage")
  end
end
