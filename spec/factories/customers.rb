FactoryGirl.define do
  sequence :email do |n|
    Faker::Internet.email.sub(/@/, "#{n}@")
  end

  factory :customer do
    email
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
  end

end
