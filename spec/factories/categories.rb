FactoryGirl.define do
  sequence :title do |n|
    "New Category Title#{n}"
  end
  factory :category do
    title
  end

end
