FactoryBot.define do
  factory :order_item do
    quantity { rand(1..10) }
    association(:order)
    association(:book)
  end
end
