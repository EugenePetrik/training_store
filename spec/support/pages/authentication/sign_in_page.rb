class SignInPage < BasePage
  set_url '/users/sign_in'

  element :fb_icon, 'a.general-login-icon'
  element :sign_up_title, 'h3.general-login-title', text: 'Log In'

  element :email, '#user_email'
  element :password, '#user_password'
  element :login_button, '[name="commit"]'

  element :remember_me, '.checkbox-label'
  element :back_button, '.btn', text: /back to store/i

  def login_with(options = {})
    email.set(options[:email])
    password.set(options[:password])
    login_button.click
  end
end
