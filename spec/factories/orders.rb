FactoryGirl.define do
  factory :order do
    total { Faker::Commerce.price }
    completed { Faker::Date.between(2.days.ago, Date.today) }
    state { Order::STATES.sample }
    customer
    credit_card
    billing_address
    shipping_address
  end

end

