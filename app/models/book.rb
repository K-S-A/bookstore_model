class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :author
  has_many :ratings
  has_many :customers, through: :ratings
  
  validates_presence_of :title, :price, :amount
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :amount, only_integer: true

end
