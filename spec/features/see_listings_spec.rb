require 'spec_helper'
require 'web_helper'

feature "See listings" do

  before(:each) do
    visit '/'
    click_button("Sign up")
    sign_up
    create_listing
  end

  scenario "user can view the listings on the home page if logged in" do
      visit '/'
      expect(page).to have_content("A Lovely Cottage")

  end

  scenario "user can view listings on home page if not logged in" do
    log_out
    visit '/'
    expect(page).to have_content("A Lovely Cottage")

  end

  scenario "user can click through to see details of a particular listing" do
    visit '/'
    click_link("A Lovely Cottage")
    expect(page).to have_content("A Lovely Cottage")
    expect(page).to have_content("Includes jacuzzi")
    expect(page).to have_content("12.5")
  end

end
