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

def log_in
  fill_in("username", with: "Oscar")
  fill_in("password", with: "test")
  click_button("Log In")
end

def failed_log_in_wrong_username
  fill_in("username", with: "Oscar2")
  fill_in("password", with: "test")
  click_button("Log In")
end

def log_out
    click_button("Log Out")
end

def create_listing
  visit '/listing/new'
  fill_in("name", with: "A Lovely Cottage")
  fill_in("price", with: 12.5)
  fill_in("description", with: "Includes jacuzzi")
  click_button("Add Listing")
end
