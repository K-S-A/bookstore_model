FactoryGirl.define do
  factory :book do
    title { Faker::Name.title }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price }
    amount { Faker::Number.between(1, 30) }
    category
  end

end
