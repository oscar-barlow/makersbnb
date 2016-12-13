require 'spec_helper'
require 'web_helper'

feature "See all listings" do

  scenario "whether use is logged in or not, & they visit the homepage & see all the listings" do

      visit '/'
      click_button("Sign up")
      sign_up
      visit '/listing/new'
      fill_in("name", with: "A Lovely Cottage")
      fill_in("price", with: 12.5)
      fill_in("description", with: "Includes jacuzzi")
      click_button("Add Listing")
      visit '/'
      expect(page).to have_content("A Lovely Cottage")
      click_button("Log Out")
      visit '/'
      expect(page).to have_content("A Lovely Cottage")

  end

end
