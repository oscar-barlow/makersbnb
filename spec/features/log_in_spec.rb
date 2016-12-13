require 'spec_helper'
require 'web_helper'

feature "Log in" do

  before(:each) do
    visit '/sign_up'
    sign_up
  end

  it("should allow a user to log into MakersBnb") do
  visit '/log_in'
  expect(page.status_code).to eq(200)

  fill_in("email", with: "ocsar@gmail.com")
  fill_in("password", with: "test")
  click_button("Log In")
  expect(page.current_path).to eq('/listing')
  expect(page).to have_content("Hello Oscar")
  end
end
