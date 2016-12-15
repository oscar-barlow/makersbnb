require 'spec_helper'
require 'web_helper'

feature "Set a listing unavailable" do

  before(:each) do
    visit '/'
    click_button("Sign up")
    sign_up
    create_listing
  end

  scenario "listing owner sets a date when the listing is unavailable" do
    click_link("A Lovely Cottage")
    click_button("Date Unavailability")
    expect(page.current_path).to eq '/listing/1/unavailable/new'
    fill_in("date", with: "01-02-2017")
    click_button("Submit")
    expect(page.current_path).to eq '/listing/1'
    expect(page).to have_content("This space is unavailable on:")
    expect(page).to have_content("1 February 2017")
  end

end
