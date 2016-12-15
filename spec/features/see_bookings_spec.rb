require 'spec_helper'
require 'web_helper'

feature "See bookings" do

  before(:each) do
    visit '/user/new'
    sign_up
    create_listing("see bookings listing") 
    visit('/listing/8')
    fill_in("date", with: "02-01-2017")
    click_button("Request booking")
  end

  scenario "user traveler sees bookings they have made" do
    visit '/user/bookings'
    expect(page).to have_content("A Lovely Cottage")
    expect(page).to have_content("2 February 2017")
  end
end
