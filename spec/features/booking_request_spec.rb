require 'spec_helper'
require 'web_helper'

feature "Booking" do

  before(:each) do
    visit '/user/new'
    sign_up
    create_listing
    visit '/listing/1/booking/new'
    click_button("Request booking")
  end

  it("should fill out request booking form and go to confirmation page") do
    visit '/listing/1/booking/new'
    fill_in("check_in", with: "01-01-2017")
    fill_in("message", with: "I would like cake on arrival")
    click_button("Request booking")

    expect(page.current_path).to eq('/listing/1/booking/confirmation')
    expect(page).to have_content('Confirmation')
  end
end
