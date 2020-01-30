# frozen_string_literal: true

class LoginPage < BasePage
  set_url '/login'

  element :log_in_title, 'h3.header'
  element :email, '#logins_email'
  element :password, '#logins_password'
  element :log_in_button, 'button[name="button"]'

  def login_with(options = {})
    email.set(options[:email])
    password.set(options[:password])
    log_in_button.click
  end
end
