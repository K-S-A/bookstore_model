require 'rails_helper'

RSpec.describe Author, type: :model do
  subject { FactoryGirl.create :author }

# Associations tests
  it { expect(subject).to have_many(:books).dependent(:destroy) }

#Validations tests
  it { expect(subject).to validate_presence_of(:firstname) }
  it { expect(subject).to validate_presence_of(:lastname) }

end
