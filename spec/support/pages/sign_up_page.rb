class SignUpPage < BasePage
  set_url '/users/sign_up'

  element :email, '#user_email'
  element :password, '#user_password'
  element :password_confirmation, '#user_password_confirmation'
  element :sign_up_button, '[name="commit"]'

  def sign_up_as(options = {})
    email.set(options[:email])
    password.set(options[:password])
    password_confirmation.set(options[:password_confirmation])
    sign_up_button.click
  end
end
