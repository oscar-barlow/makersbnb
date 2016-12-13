require 'spec_helper'
require 'web_helper'

feature "Log in" do

  before(:each) do
    visit '/user/new'
    sign_up
    log_out
  end

  it("should allow a user to log into MakersBnb") do
    visit '/session/new'
    expect(page.status_code).to eq(200)

    log_in
    expect(page.current_path).to eq('/')
    expect(page).to have_content("Hello Oscar")
  end

  it("should not allow me to log in if my username does not match my registered username") do
    visit '/session/new'
    expect(page.status_code).to eq(200)

    failed_log_in_wrong_username
    expect(page.current_path).to eq('/session/new')
    expect(page).to have_content("Your details are incorrect")
  end

  it("should redirect user to listing page if they are already logged in") do
    visit '/session/new'
    log_in
    visit '/session/new'
    expect(page.status_code).to eq(200)
    expect(page.current_path).to eq('/')
  end
end
