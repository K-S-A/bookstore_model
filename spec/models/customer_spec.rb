require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { FactoryGirl.create :customer }

# Associations tests
  it { expect(subject).to have_many(:orders).dependent(:destroy) }
  it { expect(subject).to have_many(:ratings) }

#Validations tests
  [:email, :password, :firstname, :lastname].each do |field|
    it { expect(subject).to validate_presence_of(field) }
  end
  it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }
  it 'should not allow emails of invalid format' do
    expect(subject).not_to allow_value('moc@com').for(:email)
  end
  it 'should allow only emails of valid format' do
    expect(subject).to allow_value('my@mail.com').for(:email)
  end

#Callbacks tests
  it 'should save email only in downcase form' do
    expect((FactoryGirl.create(:customer, email: 'MY@mAiL.coM')).email).to eq('my@mail.com')
   end

end
