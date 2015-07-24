class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order, touch: true

  validates_presence_of :price, :quantity
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :quantity, only_integer: true,
                                       greater_than: 0

end
