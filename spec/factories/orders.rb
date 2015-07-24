FactoryGirl.define do
  factory :order do
    total { Faker::Commerce.price }
    completed { Faker::Date.between(2.days.ago, Date.today) }
    state { Order::STATES.sample }
    customer
    credit_card
    billing_address
    shipping_address

    factory :order_in_progress do
      state { 'in progress' }
    end
    factory :order_completed do
      state { 'completed' }
    end
  end

end

