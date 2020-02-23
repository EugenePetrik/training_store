class AddressGeneralSection < SitePrism::Section
  element :first_name, '[id$=first_name]'
  element :last_name, '[id$=last_name]'
  element :address, '[name$="[address]"]'
  element :city, '[id$=city]'
  element :zip, '[id$=zip]'
  element :country, '[id$=country]'
  element :phone, '[id$=phone]'
  element :save_button, '[name="commit"]'

  # Error messages
  element :first_name_error, '[id$=first_name] + .invalid-feedback'
  element :last_name_error, '[id$=last_name] + .invalid-feedback'
  element :address_error, '[name$="[address]"] + .invalid-feedback'
  element :city_error, '[id$=city] + .invalid-feedback'
  element :zip_error, '[id$=zip] + .invalid-feedback'
  element :country_error, '[id$=country] + .invalid-feedback'
  element :phone_error, '[id$=phone] + .invalid-feedback'

  def fill_in_address_with(options = {})
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
