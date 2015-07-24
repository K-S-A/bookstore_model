FactoryGirl.define do
  factory :rating do
    review { Faker::Lorem.paragraph }
    rate { Faker::Number.between(1, 10) }
    book
    customer
  end

end
