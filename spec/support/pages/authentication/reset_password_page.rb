class ResetPasswordPage < BasePage
  set_url_matcher(%r{/users/password/edit\?reset_password_token=\w+})

  element :change_pass_title, 'h2.general-login-title'
  element :user_pass, '#user_password'
  element :user_pass_confirm, '#user_password_confirmation'
  element :change_pass_button, 'input[name="commit"]'

  expected_elements :change_pass_title, :user_pass, :user_pass_confirm, :change_pass_button

  # Errors messages
  element :pass_error, '[for="user_password"]+.invalid-feedback'
  element :pass_confirm_error, '[for="user_password_confirmation"]+.invalid-feedback'

  def change_pass_with(options = {})
    user_pass.set(options[:password])
    user_pass_confirm.set(options[:password_confirmation])
    change_pass_button.click
  end
end
