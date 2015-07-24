require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { FactoryGirl.create :category }

# Associations tests
  it { expect(subject).to have_many(:books).dependent(:destroy) }

#Validations tests
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_uniqueness_of(:title).case_insensitive }

end
