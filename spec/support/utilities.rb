include ApplicationHelper

def click_home
  click_link 'Home'
end

def click_signout
  click_link 'Sign out'
end

def click_about
  click_link 'About'
end

def click_help
  click_link 'Help'
end

def click_contact
  click_link 'Contact'
end

def click_sampleapp
  click_link 'sample app'
end

def click_signup
  click_link 'Sign up now!'
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end

def fill_in_user(user)
  fill_in "Name", with: user.name
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  fill_in "Confirmation", with: user.password_confirmation

end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end