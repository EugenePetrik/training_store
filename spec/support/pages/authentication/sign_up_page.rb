class SignUpPage < BasePage
  set_url '/users/sign_up'

  element :fb_icon, 'a.general-login-icon'
  element :sign_up_title, 'h3.general-login-title', text: 'Sign up'

  element :email, '#user_email'
  element :password, '#user_password'
  element :password_confirmation, '#user_password_confirmation'
  element :sign_up_button, '[name="commit"]'

  expected_elements :fb_icon, :sign_up_title, :email, :password, :password_confirmation, :sign_up_button

  # Errors messages
  element :email_error, '[for="user_email"]+.invalid-feedback'
  element :pass_error, '[for="user_password"]+.invalid-feedback'
  element :pass_confirm_error, '[for="user_password_confirmation"]+.invalid-feedback'

  def sign_up_with(options = {})
    email.set(options[:email])
    password.set(options[:password])
    password_confirmation.set(options[:password_confirmation])
    sign_up_button.click
  end
end
