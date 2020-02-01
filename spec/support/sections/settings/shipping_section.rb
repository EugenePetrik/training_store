class ShippingSection < SitePrism::Section
  element :first_name, '#shipping_address_first_name'
  element :last_name, '#shipping_address_last_name'
  element :address, '#shipping_address_address'
  element :city, '#shipping_address_city'
  element :zip, '#shipping_address_zip'
  element :country, '#shipping_address_country'
  element :phone, '#shipping_address_phone'
  element :save_button, '[name="commit"]'

  # Error messages
  element :first_name_error, '#shipping_address_first_name+.invalid-feedback'
  element :last_name_error, '#shipping_address_last_name+.invalid-feedback'
  element :address_error, '#shipping_address_address+.invalid-feedback'
  element :city_error, '#shipping_address_city+.invalid-feedback'
  element :zip_error, '#shipping_address_zip+.invalid-feedback'
  element :country_error, '#shipping_address_country+.invalid-feedback'
  element :phone_error, '#shipping_address_phone+.invalid-feedback'

  def fill_in_shipping_address_with(options = {})
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
