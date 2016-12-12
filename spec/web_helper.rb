def sign_up
  visit '/sign_up'
  expect(page.status_code).to eq(200)

  fill_in("username", with: "Oscar")
  fill_in("email", with: "oscar@gmail.com")
  fill_in("password", with: "test")
  click_button("Sign Up")
end
