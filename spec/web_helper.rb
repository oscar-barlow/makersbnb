def sign_up
  fill_in("username", with: "Oscar")
  fill_in("email", with: "oscar@gmail.com")
  fill_in("password", with: "test")
  click_button("Sign Up")
end

def failed_sign_up_uniqueness
  fill_in("username", with: "Oscar")
  fill_in("email", with: "oscar@gmail.com")
  fill_in("password", with: "test")
  click_button("Sign Up")
end

def failed_sign_up_email_format
  fill_in("username", with: "Oscar")
  fill_in("email", with: "oscargmailcom")
  fill_in("password", with: "test")
  click_button("Sign Up")
end
