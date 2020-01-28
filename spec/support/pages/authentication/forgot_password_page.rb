class ForgotPasswordPage < BasePage
  set_url '/users/password/new'

  element :user_email, '#user_email'
  element :reset_pass_button, '[name="commit"]'

  def reset_password_with(email)
    user_email.set(email)
    reset_pass_button.click
  end
end
