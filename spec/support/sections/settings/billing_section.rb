class BillingSection < SitePrism::Section
  element :first_name, '#billing_address_first_name'
  element :last_name, '#billing_address_last_name'
  element :address, '#billing_address_address'
  element :city, '#billing_address_city'
  element :zip, '#billing_address_zip'
  element :country, '#billing_address_country'
  element :phone, '#billing_address_phone'
  element :save_button, '[name="commit"]'

  # Error messages
  element :first_name_error, '#billing_address_first_name+.invalid-feedback'
  element :last_name_error, '#billing_address_last_name+.invalid-feedback'
  element :address_error, '#billing_address_address+.invalid-feedback'
  element :city_error, '#billing_address_city+.invalid-feedback'
  element :zip_error, '#billing_address_zip+.invalid-feedback'
  element :country_error, '#billing_address_country+.invalid-feedback'
  element :phone_error, '#billing_address_phone+.invalid-feedback'

  def fill_in_billing_address_with(options = {})
    first_name.set(options[:first_name]) unless options[:first_name].nil?
    last_name.set(options[:last_name]) unless options[:last_name].nil?
    address.set(options[:address]) unless options[:address].nil?
    city.set(options[:city]) unless options[:city].nil?
    zip.set(options[:zip]) unless options[:zip].nil?
    country.select(options[:country]) unless options[:country].nil?
    phone.set(options[:phone]) unless options[:phone].nil?
    save_button.click
  end
end
