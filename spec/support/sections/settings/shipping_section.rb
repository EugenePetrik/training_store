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
    fill_in_first_name(options[:first_name])
    fill_in_last_name(options[:last_name])
    fill_in_address(options[:address])
    fill_in_city(options[:city])
    fill_in_zip(options[:zip])
    select_country(options[:country])
    fill_in_phone(options[:phone])
    save_button.click
  end

  private

  def fill_in_first_name(first_name)
    self.first_name.set(first_name)
  end

  def fill_in_last_name(last_name)
    self.last_name.set(last_name)
  end

  def fill_in_address(address)
    self.address.set(address)
  end

  def fill_in_city(city)
    self.city.set(city)
  end

  def fill_in_zip(zip)
    self.zip.set(zip)
  end

  def select_country(country)
    self.country.select(country)
  end

  def fill_in_phone(phone)
    self.phone.set(phone)
  end
end
