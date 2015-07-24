FactoryGirl.define do
  factory :address, aliases: [:billing_address, :shipping_address] do
    address { Faker::Address.street_address }
    zipcode { Faker::Address.zip_code[0..4] }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.phone_number.gsub(/\D/,'')[0..9] }
    country
  end

end
