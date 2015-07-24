FactoryGirl.define do
  sequence :name do |n|
    Carmen::Country.all.map(&:name)[n]
  end

  factory :country do
    name
  end

end
