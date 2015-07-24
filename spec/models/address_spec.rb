require 'rails_helper'

RSpec.describe Address, type: :model do
  subject { FactoryGirl.create(:address) }

# Associations tests
  it { expect(subject).to belong_to(:country) }
  it { expect(subject).to have_many(:billing_orders).
    class_name('Order').
    with_foreign_key(:billing_address_id) }
  it { expect(subject).to have_many(:shipping_orders).
    class_name('Order').
    with_foreign_key(:shipping_address_id) }

#Validations tests
  [:address, :zipcode, :city, :phone, :country].each do |f|
    it { expect(subject).to validate_presence_of(f) }
  end
  it 'should validate associated country' do
    subject.country.name = 'Faked Country'
    expect(subject).not_to be_valid
  end

  context '#zipcode' do
    %w(123456 1234 123\ 5 a1234 1234-).each do |v|
      it { expect(subject).to_not allow_value(v).for(:zipcode) }
    end
    it { expect(subject).to allow_value('12345').for(:zipcode) }
  end
  context '#phone' do
    %w(a - 9 \ ).each do |e|
      it { expect(subject).not_to allow_value(Faker::PhoneNumber.phone_number.gsub(/\D/,'')[0..9] + e).for(:phone) }
    end
    it { expect(subject).to allow_value(Faker::PhoneNumber.phone_number.gsub(/\D/,'')[0..9]).for(:phone) }
  end
end
