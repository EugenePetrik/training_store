FactoryBot.define do
  factory :book do
    slug { FFaker::Internet.slug.tr('.', '-') }
    publication_year { FFaker::Vehicle.year }
    material { FFaker::Lorem.word }
    width { rand(20.0..100.0).round(2) }
    height { rand(20..30) }
    depth { rand(20..30) }
    sold { 0 }
    quantity { rand(1..100) }
    description { FFaker::Book.description }
    price { (20..100).to_a.sample }
    title { FFaker::Book.title }
    association(:category)
  end

  trait :with_author do
    after(:create) do |book|
      book.authors << create(:author)
    end
  end
end
