require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject { FactoryGirl.create(:order_item) }

# Associations tests
  it { expect(subject).to belong_to(:book) }
  it { expect(subject).to belong_to(:order).touch(true) }

#Validations tests
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:quantity) }
  it { expect(subject).to validate_numericality_of(:price).is_greater_than(0) }
  it { expect(subject).to validate_numericality_of(:quantity).
    only_integer.
    is_greater_than(0) }

end
