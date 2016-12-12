require 'spec_helper'
require 'web_helper'

feature "User" do
  scenario "I want to be able sign up to MarkersBnB" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Hello Oscar')
  end
end
