class Order < ActiveRecord::Base
  STATES = %w(in\ progress completed shipped)

  has_many :order_items, dependent: :destroy
  belongs_to :customer, touch: true
  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  before_validation { self.state ||= STATES.first }
  before_save :calc_total

  validates_presence_of :total, :billing_address, :shipping_address
  validates_presence_of :completed, if: :order_completed?
  validates_numericality_of :total, greater_than_or_equal_to: 0
  validates_inclusion_of :state, in: STATES

scope :in_progress, -> {where(state: STATES[0])}

  def add_item(book, quantity = 1)
    if existing_item = order_items.find_by(book: book)
      existing_item.update(quantity: existing_item.quantity += quantity)
    else
      order_items.create(price: book.price, quantity: quantity, book: book)
    end
  end

  protected

  def order_completed?
    state == STATES[1]
  end

  private

  def calc_total
    if order_items.any?
      self.total = 0
      ::OrderItem.where(order_id: self.id).find_each{ |i| self.total += i.price * i.quantity }
    else
      self.total = 0.0
    end
  end

end
