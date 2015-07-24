FactoryGirl.define do
  factory :credit_card do
    number { Faker::Business.credit_card_number.gsub(/-/, "") }
    cvv { Faker::Number.between(100, 9999) }
    exp_month { Faker::Business.credit_card_expiry_date.month }
    exp_year { Faker::Date.between(Date.today, Date.today.years_since(20)).year }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    customer
  end

end
