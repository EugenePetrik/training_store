RSpec.describe 'BillingAddress' do
  let(:settings_page) { SettingsPage.new }

  let(:user) { create(:user) }

  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }
  let(:address) { FFaker::AddressUS.street_name }
  let(:city) { FFaker::AddressUS.city }
  let(:zip) { rand(1..100_000).to_s }
  let(:country) { %w[Ukraine Germane USA UK].sample }
  let(:phone) { FFaker::PhoneNumberUA.international_mobile_phone_number.gsub!(/[\s-]/, '') }
  let(:special_chars) { %w[! @ # $ % ^ & * ~].sample(rand(1..5)).join }

  let(:params_billing_address) do
    {
      first_name: first_name,
      last_name: last_name,
      address: address,
      city: city,
      zip: zip,
      country: country,
      phone: phone
    }
  end

  let(:error_field_blank) { "can't be blank" }
  let(:error_max_50_chars) { 'is too long (maximum is 50 characters)' }
  let(:error_max_20_chars) { 'is too long (maximum is 20 characters)' }
  let(:error_max_13_chars) { 'is too long (maximum is 13 characters)' }
  let(:error_max_5_chars) { 'is too long (maximum is 5 characters)' }
  let(:error_min_5_chars) { 'is too short (minimum is 5 characters)' }
  let(:error_address_invalid) { 'Address must be format `Bojenko 100, 23`' }
  let(:error_zip_invalid) { 'is invalid' }
  let(:error_phone_invalid) { 'Phone must be format +38002353535' }

  before do
    login_as(user)
    settings_page.load
  end

  context 'when open page' do
    it { expect(settings_page).to be_displayed }
    it { expect(settings_page).to be_all_there }
  end

  context 'with correct data' do
    it 'creates billing address' do
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed

      settings_page.billing_address do |billing|
        expect(billing.first_name.value).to eq(first_name)
        expect(billing.last_name.value).to eq(last_name)
        expect(billing.address.value).to eq(address)
        expect(billing.city.value).to eq(city)
        expect(billing.zip.value).to eq(zip)
        expect(billing.country.value).to eq(country)
        expect(billing.phone.value).to eq(phone)
      end
    end
  end

  context 'with empty first name' do
    it 'raises an error' do
      params_billing_address[:first_name] = ''
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.first_name_error.text).to eq(error_field_blank)
    end
  end

  context 'with too long first name' do
    it 'raises an error' do
      params_billing_address[:first_name] = FFaker::Lorem.characters(rand(51..100))
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.first_name_error.text).to eq(error_max_50_chars)
    end
  end

  context 'with numbers in first name' do
    it 'raises an error' do
      params_billing_address[:first_name] = rand(10_000)
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.first_name_error.text).to eq(error_field_blank)
    end
  end

  context 'with special characters in first name' do
    it 'raises an error' do
      params_billing_address[:first_name] += special_chars
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.first_name_error.text).to eq(error_field_blank)
    end
  end

  context 'with empty last name' do
    it 'raises an error' do
      params_billing_address[:last_name] = ''
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.last_name_error.text).to eq(error_field_blank)
    end
  end

  context 'with too long last name' do
    it 'raises an error' do
      params_billing_address[:last_name] = FFaker::Lorem.characters(rand(51..100))
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.last_name_error.text).to eq(error_max_50_chars)
    end
  end

  context 'with numbers in last name' do
    it 'raises an error' do
      params_billing_address[:last_name] = rand(10_000)
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.last_name_error.text).to eq(error_field_blank)
    end
  end

  context 'with special characters in last name' do
    it 'raises an error' do
      params_billing_address[:last_name] += special_chars
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.last_name_error.text).to eq(error_field_blank)
    end
  end

  context 'with empty address' do
    it 'raises an error' do
      params_billing_address[:address] = ''
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.address_error.text).to eq(error_field_blank)
    end
  end

  context 'with too short address' do
    it 'raises an error' do
      params_billing_address[:address] = FFaker::Lorem.characters(rand(1..4))
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.address_error.text).to eq(error_min_5_chars)
    end
  end

  context 'with too long address' do
    it 'raises an error' do
      params_billing_address[:address] = FFaker::Lorem.characters(rand(21..50))
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.address_error.text).to eq(error_max_20_chars)
    end
  end

  context 'with special characters in address' do
    it 'raises an error' do
      params_billing_address[:address] = FFaker::AddressUS.street_suffix + special_chars
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.address_error.text).to eq(error_address_invalid)
    end
  end

  context 'with empty city' do
    it 'raises an error' do
      params_billing_address[:city] = ''
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.city_error.text).to eq(error_field_blank)
    end
  end

  context 'with too long city' do
    it 'raises an error' do
      params_billing_address[:city] = FFaker::Lorem.characters(rand(51..100))
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.city_error.text).to eq(error_max_50_chars)
    end
  end

  context 'with numbers in city' do
    it 'raises an error' do
      params_billing_address[:city] = rand(10_000)
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.city_error.text).to eq(error_field_blank)
    end
  end

  context 'with empty zip code' do
    it 'raises an error' do
      params_billing_address[:zip] = ''
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.zip_error.text).to eq(error_field_blank)
    end
  end

  context 'with too long zip code' do
    it 'raises an error' do
      params_billing_address[:zip] = rand(1_000_000..100_000_000)
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.zip_error.text).to eq(error_max_5_chars)
    end
  end

  context 'with characters in zip code' do
    it 'raises an error' do
      params_billing_address[:zip] = FFaker::Lorem.characters(rand(2..5))
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.zip_error.text).to eq(error_zip_invalid)
    end
  end

  context 'with special characters in zip code' do
    it 'raises an error' do
      params_billing_address[:zip] = special_chars
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.zip_error.text).to eq(error_zip_invalid)
    end
  end

  context 'with empty country' do
    it 'raises an error' do
      params_billing_address[:country] = ''
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.country_error.text).to eq(error_field_blank)
    end
  end

  context 'with empty phone number' do
    it 'raises an error' do
      params_billing_address[:phone] = ''
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.phone_error.text).to eq(error_field_blank)
    end
  end

  context 'with too long phone number' do
    it 'raises an error' do
      params_billing_address[:phone] += rand(1000).to_s
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.phone_error.text).to eq(error_max_13_chars)
    end
  end

  context 'with characters in phone number' do
    it 'raises an error' do
      params_billing_address[:phone] += special_chars
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.phone_error.text).to eq(error_max_13_chars)
    end
  end

  context 'with invalid phone number format' do
    it 'raises an error' do
      params_billing_address[:phone] = rand(100_000_000)
      settings_page.billing_address.fill_in_address_with(params_billing_address)

      expect(settings_page).to be_displayed
      expect(settings_page.billing_address.phone_error.text).to eq(error_phone_invalid)
    end
  end
end
