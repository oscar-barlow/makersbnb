require 'spec_helper'
require 'web_helper'

feature "Log Out" do

  before(:each) do
    sign_up
    log_in
  end

  it("should allow a user to log out of MakersBnB") do
    click_button("Sign Out")
    expect(page).to have_content("Goodbye")
    expect(page.current_path).to eq ('/goodbye')
  end
end
