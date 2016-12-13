require 'spec_helper'
require 'web_helper'

feature "User" do

  before(:each) do
    visit '/user/new'
    expect(page.status_code).to eq(200)
  end

  scenario "I want to be able sign up to MarkersBnB" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page.current_path).to eq('/')
    expect(page).to have_content('Hello Oscar')
  end

  scenario "I don't want to be able to sign up if my username or email is not unique" do
    sign_up
    visit '/user/new'
    expect(page.status_code).to eq(200)
    expect{ failed_sign_up_uniqueness }.to_not change(User, :count)
    expect(page.current_path).to eq('/user/new')
    expect(page).to have_content("Username is already taken")
    expect(page).to have_content("Email is already taken")
  end

  scenario "I don't want to be able to sign up if I do not have the correct email format" do
    sign_up
    visit '/user/new'
    expect(page.status_code).to eq(200)
    expect{ failed_sign_up_email_format }.to_not change(User, :count)
    expect(page.current_path).to eq('/user/new')
    expect(page).to have_content("Username is already taken")
    expect(page).to have_content("Email has an invalid format")
  end

  scenario "I want to be able to see a way to sign up if I am not already" do
    visit '/listing1'
    expect(page).to have_content("Sign up")
  end

end
