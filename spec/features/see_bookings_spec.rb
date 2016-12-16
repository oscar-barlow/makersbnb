require 'spec_helper'
require 'web_helper'

feature "See bookings" do

  before(:each) do
    visit '/user/new'
    sign_up
    create_listing("see bookings listing")
    log_out
    visit '/user/new'
    sign_up_new_user
    visit ('/')
    click_link("see bookings listing")
    visit('/listing/3')
    click_button("Request booking")
    fill_in("check_in", with: "02-01-2017")
    click_button("Request booking")
  end

  scenario "user traveler sees bookings they have made" do
    visit '/booking/3'
    expect(page).to have_content("see bookings listing")
    expect(page).to have_content("2 February 2017")
  end
end
