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

  scenario "user can make a request to book a particular listing" do
    visit '/'
    click_link("A Lovely Cottage")
    click_button("Request booking")
    expect(page.current_path).to eq('/booking/new')
    expect(page.status_code).to eq(200)
    expect(page).to have_content("Request booking")
    expect(page).to have_content("Oscar")
    expect(page).to have_content("Check in date")
    expect(page).to have_content("Message")
  end

end
