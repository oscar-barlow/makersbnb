require 'spec_helper'
require 'web_helper'

feature "See all listings" do

  before(:each) do
    visit '/'
    click_button("Sign up")
    sign_up
    create_listing
  end

  scenario "user can view the listings on the home page whether if logged in" do
      visit '/'
      expect(page).to have_content("A Lovely Cottage")

  end

  scenario "user can view listings on home page if not logged in" do
    log_out
    visit '/'
    expect(page).to have_content("A Lovely Cottage")

  end

end
