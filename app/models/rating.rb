class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer

  validates_presence_of :review, :rate
  validates_inclusion_of :rate, in: 1..10
end
