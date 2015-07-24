require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  subject { FactoryGirl.create(:credit_card) }

# Associations tests
  it { expect(subject).to belong_to(:customer) }
  it { expect(subject).to have_many(:orders) }

#Validations tests
  [:number, :cvv, :exp_month, :exp_year, :firstname, :lastname].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end
  it { expect(subject).to validate_inclusion_of(:cvv).in_range(100..9999) }
  it { expect(subject).to validate_inclusion_of(:exp_month).in_range(1..12) }
  it { expect(subject).to validate_numericality_of(:exp_year).
    only_integer.
    is_greater_than_or_equal_to(Date.today.year) }

  context '#number' do
    ['a1234567890123456', '1234567c90123456b', '123456789012345a',
      '123456789012345', '12345678901234567', '1234-6789_1234/6'].each do |v|
      it { expect(subject).to_not allow_value(v).for(:number) }
    end
    it { expect(subject).to allow_value('1234567890123456').for(:number) }
  end

end
