FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    trait :admin do
      admin { true }
    end

    trait :with_order do
      after(:create) do |user|
        user.orders << create(:order, :with_order_items, user: user)
      end
    end
  end
end
