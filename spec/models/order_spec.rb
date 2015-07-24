require 'rails_helper'

RSpec.describe Order, type: :model do
  STATES = %w(in\ progress completed shipped)

  subject { FactoryGirl.create(:order) }

# Associations tests
  it { expect(subject).to belong_to(:customer).touch(true) }
  it { expect(subject).to belong_to(:credit_card) }
  it { expect(subject).to have_many(:order_items).dependent(:destroy) }
  it { expect(subject).to belong_to(:billing_address).class_name('Address') }
  it { expect(subject).to belong_to(:shipping_address).class_name('Address') }

#Validations tests
  [:total, :billing_address, :shipping_address].each do |f|
    it { expect(subject).to validate_presence_of(f) }
  end
  it { expect(subject).to validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  it { expect(subject).to validate_inclusion_of(:state).in_array(STATES) }
  it 'should require completed date if order completed' do
    allow(subject).to receive(:state).and_return(STATES[1])
    expect(subject).to validate_presence_of(:completed)
  end
  it 'should not require completed date if order is in progress' do
    allow(subject).to receive(:state).and_return(STATES.first)
    expect(subject).to_not validate_presence_of(:completed)
  end

#Callbacks tests
  it "should have default state 'in progress'" do
    expect(FactoryGirl.create(:order, state: nil).state).to eq(STATES.first)
  end

#
  context '#add_item' do
    before { @book = FactoryGirl.create(:book) }
    context 'when adding not existing order item (book)' do
      context 'without quantity specified' do
        it 'should add book as new order item' do
          expect{ subject.add_item(@book) }.to change{ subject.order_items.count }.by(1)
        end
        it 'should set order item quantity to (1)' do
          subject.add_item(@book)
          expect(subject.order_items.first.quantity).to eq(1)
        end
      end
      context 'with quantity specified' do
        it 'should set order item quantity to (1)' do
          subject.add_item(@book, 12)
          expect(subject.order_items.first.quantity).to eq(12)
        end
      end
    end
    context 'when added book already exists in order items' do
      it 'should not add new order item' do
        expect{ 5.times{ subject.add_item(@book) } }.to change{ subject.order_items.count }.by(1)
      end
      it 'should acumulate quantities of books' do
        subject.add_item(@book)
        expect{ 5.times{ subject.add_item(@book, 2) } }.to change{ subject.order_items.first.quantity }.by(10)
      end
    end
  end
  context '#total' do
    it 'should set total price to 0 if no order items available' do
      expect(subject.total).to eq(0)
    end
    it 'should set total price of items (books) added' do
      FactoryGirl.create(:order_item, price: 10.21, quantity: 20, order: subject)
      FactoryGirl.create(:order_item, price: 100.43, quantity: 27, order: subject)
      subject.save
      expect(subject.total).to eq(2915.81)
    end
  end

end
