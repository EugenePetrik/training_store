class UpdateEmailSection < SitePrism::Section
  element :email_field, '#email_form_email'
  element :save_button, '[name="commit"]'

  def update_email_with(email)
    email_field.set(email)
    save_button.click
  end
end
