FactoryBot.define do
  factory :order do
    total { 10 }
    status { Order.aasm(:status).states.first.name }
    checkout { Order.aasm(:checkout).states.first.name }
    association(:user)

    trait :with_order_items do
      after(:create) do |order|
        order.order_items << create(:order_item)
      end
    end
  end
end
