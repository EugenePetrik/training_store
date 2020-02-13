RSpec.describe 'ShippingAddress' do
  let(:settings_page) { SettingsPage.new }
  let(:user) { create(:user) }
  let(:special_chars) { %w[! @ # $ % ^ & * ~].sample(rand(1..5)).join }
  let(:error_field_blank) { I18n.t('forms.fields') }
  let(:error_max_50_chars) { 'is too long (maximum is 50 characters)' }
  let(:error_max_20_chars) { 'is too long (maximum is 20 characters)' }
  let(:error_max_13_chars) { 'is too long (maximum is 13 characters)' }
  let(:error_max_5_chars) { 'is too long (maximum is 5 characters)' }
  let(:error_min_5_chars) { 'is too short (minimum is 5 characters)' }
  let(:error_address_invalid) { I18n.t('forms.address') }
  let(:error_zip_invalid) { 'is invalid' }
  let(:error_phone_invalid) { 'Phone must be format +38002353535' }

  context 'with pre-filled in shipping address' do
    let!(:shipping_address) { create(:shipping_address, addressable: user) }

    before do
      login_as(user)
      settings_page.load
    end

    context 'when open page' do
      it 'shows filled in shipping address' do
        expect(settings_page).to be_displayed

        settings_page.shipping_address do |shipping|
          expect(shipping.first_name.value).to eq(shipping_address.first_name)
          expect(shipping.last_name.value).to eq(shipping_address.last_name)
          expect(shipping.address.value).to eq(shipping_address.address)
          expect(shipping.city.value).to eq(shipping_address.city)
          expect(shipping.zip.value).to eq(shipping_address.zip)
          expect(shipping.country.value).to eq(shipping_address.country)
          expect(shipping.phone.value).to eq(shipping_address.phone)
        end
      end
    end
  end

  context 'without pre-filled in shipping address' do
    let(:params_shipping_address) do
      attributes_for(:shipping_address)
    end

    before do
      login_as(user)
      settings_page.load
    end

    context 'when open page' do
      it { expect(settings_page).to be_displayed }
      it { expect(settings_page).to be_all_there }
    end

    context 'with correct data' do
      it 'creates shipping address' do
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed

        settings_page.shipping_address do |shipping|
          expect(shipping.first_name.value).to eq(params_shipping_address[:first_name])
          expect(shipping.last_name.value).to eq(params_shipping_address[:last_name])
          expect(shipping.address.value).to eq(params_shipping_address[:address])
          expect(shipping.city.value).to eq(params_shipping_address[:city])
          expect(shipping.zip.value).to eq(params_shipping_address[:zip])
          expect(shipping.country.value).to eq(params_shipping_address[:country])
          expect(shipping.phone.value).to eq(params_shipping_address[:phone])
        end
      end
    end

    context 'with empty first name' do
      it 'raises an error' do
        params_shipping_address[:first_name] = ''
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.first_name_error.text).to eq(error_field_blank)
      end
    end

    context 'with too long first name' do
      it 'raises an error' do
        params_shipping_address[:first_name] = FFaker::Lorem.characters(rand(51..100))
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.first_name_error.text).to eq(error_max_50_chars)
      end
    end

    context 'with numbers in first name' do
      it 'raises an error' do
        params_shipping_address[:first_name] = rand(10_000)
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.first_name_error.text).to eq(error_field_blank)
      end
    end

    context 'with special characters in first name' do
      it 'raises an error' do
        params_shipping_address[:first_name] += special_chars
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.first_name_error.text).to eq(error_field_blank)
      end
    end

    context 'with empty last name' do
      it 'raises an error' do
        params_shipping_address[:last_name] = ''
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.last_name_error.text).to eq(error_field_blank)
      end
    end

    context 'with too long last name' do
      it 'raises an error' do
        params_shipping_address[:last_name] = FFaker::Lorem.characters(rand(51..100))
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.last_name_error.text).to eq(error_max_50_chars)
      end
    end

    context 'with numbers in last name' do
      it 'raises an error' do
        params_shipping_address[:last_name] = rand(10_000)
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.last_name_error.text).to eq(error_field_blank)
      end
    end

    context 'with special characters in last name' do
      it 'raises an error' do
        params_shipping_address[:last_name] += special_chars
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.last_name_error.text).to eq(error_field_blank)
      end
    end

    context 'with empty address' do
      it 'raises an error' do
        params_shipping_address[:address] = ''
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.address_error.text).to eq(error_field_blank)
      end
    end

    context 'with too short address' do
      it 'raises an error' do
        params_shipping_address[:address] = FFaker::Lorem.characters(rand(1..4))
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.address_error.text).to eq(error_min_5_chars)
      end
    end

    context 'with too long address' do
      it 'raises an error' do
        params_shipping_address[:address] = FFaker::Lorem.characters(rand(21..50))
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.address_error.text).to eq(error_max_20_chars)
      end
    end

    context 'with special characters in address' do
      it 'raises an error' do
        params_shipping_address[:address] = FFaker::AddressUS.street_suffix + special_chars
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.address_error.text).to eq(error_address_invalid)
      end
    end

    context 'with empty city' do
      it 'raises an error' do
        params_shipping_address[:city] = ''
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.city_error.text).to eq(error_field_blank)
      end
    end

    context 'with too long city' do
      it 'raises an error' do
        params_shipping_address[:city] = FFaker::Lorem.characters(rand(51..100))
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.city_error.text).to eq(error_max_50_chars)
      end
    end

    context 'with numbers in city' do
      it 'raises an error' do
        params_shipping_address[:city] = rand(10_000)
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.city_error.text).to eq(error_field_blank)
      end
    end

    context 'with empty zip code' do
      it 'raises an error' do
        params_shipping_address[:zip] = ''
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.zip_error.text).to eq(error_field_blank)
      end
    end

    context 'with too long zip code' do
      it 'raises an error' do
        params_shipping_address[:zip] = rand(1_000_000..100_000_000)
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.zip_error.text).to eq(error_max_5_chars)
      end
    end

    context 'with characters in zip code' do
      it 'raises an error' do
        params_shipping_address[:zip] = FFaker::Lorem.characters(rand(2..5))
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.zip_error.text).to eq(error_zip_invalid)
      end
    end

    context 'with special characters in zip code' do
      it 'raises an error' do
        params_shipping_address[:zip] = special_chars
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.zip_error.text).to eq(error_zip_invalid)
      end
    end

    context 'with empty country' do
      it 'raises an error' do
        params_shipping_address[:country] = ''
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.country_error.text).to eq(error_field_blank)
      end
    end

    context 'with empty phone number' do
      it 'raises an error' do
        params_shipping_address[:phone] = ''
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.phone_error.text).to eq(error_field_blank)
      end
    end

    context 'with too long phone number' do
      it 'raises an error' do
        params_shipping_address[:phone] += rand(1000).to_s
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.phone_error.text).to eq(error_max_13_chars)
      end
    end

    context 'with characters in phone number' do
      it 'raises an error' do
        params_shipping_address[:phone] += special_chars
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.phone_error.text).to eq(error_max_13_chars)
      end
    end

    context 'with invalid phone number format' do
      it 'raises an error' do
        params_shipping_address[:phone] = rand(100_000_000)
        settings_page.shipping_address.fill_in_address_with(params_shipping_address)

        expect(settings_page).to be_displayed
        expect(settings_page.shipping_address.phone_error.text).to eq(error_phone_invalid)
      end
    end
  end
end
