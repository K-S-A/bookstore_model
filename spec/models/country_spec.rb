require 'rails_helper'

RSpec.describe Country, type: :model do
  subject { FactoryGirl.create(:country) }

# Associations tests
  it { expect(subject).to have_many(:addresses).dependent(:destroy) }

#Validations tests
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name) }
  it 'should allow only valid country names' do
    subject.name = 'United'
    expect(subject).not_to be_valid
  end

end
