require 'spec_helper'
require 'web_helper'

feature "Log Out" do

  before(:each) do
    visit '/sign_up'
    sign_up
  end

  it("should allow a user to log out of MakersBnB") do
    log_out
    expect(page).to have_content("Log In")
    expect(page.current_path).to eq ('/log_in')
  end
end
