require 'spec_helper'
require 'web_helper'

feature "Create listing" do

  before(:each) do
    visit '/sign_up'
    sign_up
  end

  scenario "Signed up user creates new listing" do
    visit '/listing/new'
    fill_in("name", with: "A Lovely Cottage")
    fill_in("price", with: 12.5)
    fill_in("description", with: "Includes jacuzzi")
    click_button("Add Listing")
    expect(page).to have_content("Your Listings")
    expect(page).to have_content("A Lovely Cottage")
  end
end
