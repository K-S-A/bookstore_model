class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :ratings

  before_save { self.email.downcase! }

  validates_presence_of :password, :firstname, :lastname
  validates_uniqueness_of :email, case_sensitive: false
  validates :email, presence: true,
                    email:    true

  def order_new
    orders.create
  end

  def current_order
    orders.in_progress.last
  end
end
