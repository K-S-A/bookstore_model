FactoryGirl.define do
  factory :country do
    name { Carmen::Country.all.map(&:name).sample }
  end

end
