class CreditCard < ActiveRecord::Base
  belongs_to :customer
  has_many :orders

  validates_presence_of :number, :cvv, :exp_month, :exp_year, :firstname, :lastname
  validates_format_of :number, with: /\A\d{16}\z/
  validates_inclusion_of :cvv, in: 100..9999
  validates_inclusion_of :exp_month, in: 1..12
  validates_numericality_of :exp_year, only_integer:             true,
                                       greater_than_or_equal_to: Date.today.year

end
