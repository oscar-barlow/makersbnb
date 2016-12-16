require 'spec_helper'
require 'web_helper'

feature "Set a listing unavailable" do

  before(:each) do
    visit '/'
    click_button("Sign up")
    sign_up
  end

  scenario "listing owner sets a date when the listing is unavailable" do
    create_listing
    click_link("A Lovely Cottage")
    click_button("Date Unavailability")
    expect(page.current_path).to eq '/listing/11/unavailable/new'
    fill_in("date", with: "01-02-2017")
    click_button("Submit")
    expect(page.current_path).to eq '/listing/11'
    expect(page).to have_content("This space is unavailable on:")
    expect(page).to have_content("1 February 2017")
  end

  scenario "traveller cannot book when listing is unavailable" do
    create_listing("Unavailable listing")
    click_link("Unavailable listing")
    click_button("Date Unavailability")
    fill_in("date", with: "10-02-2017")
    click_button("Submit")
    log_out
    visit '/user/new'
    sign_up_new_user
    click_link("Unavailable listing")
    click_button("Request booking")
    fill_in("check_in", with: "10-02-2017")
    p page.current_path
    click_button("Request booking")
    expect(page.current_path).to eq '/listing/12/booking/new'
    expect(page).to have_content("Sorry, the property is not available on that date")
  end

end
