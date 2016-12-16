require 'spec_helper'
require 'web_helper'

feature "Confirm bookings" do

  before(:each) do
    visit '/user/new'
    sign_up
    create_listing("confirm bookings listing")
    log_out
    visit '/user/new'
    sign_up_new_user
    visit ('/')
    click_link("confirm bookings listing")
    click_button("Request booking")
    fill_in("check_in", with: "02-01-2017")
    click_button("Request booking")
  end

  scenario "landlord confirms a booking request" do
    log_out
    log_in
    visit '/user/bookings'
    click_link('#2')
    click_button("Confirm Booking")
    expect(page).to have_content("confirm bookings listing")
    expect(page).to have_content("Confirmed: true")
  end

end
