class UpdatePasswordSection < SitePrism::Section
  element :old_pass, '#password_form_current_password'
  element :new_pass, '#password_form_password'
  element :confirm_pass, '#password_form_password_confirmation'
  element :save_button, '[name="commit"]'

  def update_password_with(options = {})
    old_pass.set(options[:old_pass])
    new_pass.set(options[:new_pass])
    confirm_pass.set(options[:confirm_pass])
    save_button.click
  end
end
