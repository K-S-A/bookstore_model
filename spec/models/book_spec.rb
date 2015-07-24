require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { FactoryGirl.create :book }

# Associations tests
  it { expect(subject).to belong_to(:author) }
  it { expect(subject).to belong_to(:category) }
  it { expect(subject).to have_many(:ratings) }
  it { expect(subject).to have_many(:customers).through(:ratings) }

#Validations tests
  [:title, :price, :amount].each do |f|
    it { expect(subject).to validate_presence_of(f) }
  end
  it { expect(subject).to validate_numericality_of(:price).is_greater_than(0) }
  it { expect(subject).to validate_numericality_of(:amount).only_integer }

end
