FactoryBot.define do
  factory :billing_address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::AddressUS.street_name }
    city { FFaker::AddressUS.city }
    zip { rand(1..100_000).to_s }
    country { %w[Ukraine Germane USA UK].sample }
    phone { FFaker::PhoneNumberUA.international_mobile_phone_number.gsub!(/[\s-]/, '') }
    use_billing_address { true }
    addressable { association(:user) }
  end
end

# create(:address, addressable: user)
