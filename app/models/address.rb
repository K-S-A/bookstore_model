class Address < ActiveRecord::Base
  belongs_to :country
  has_many :billing_orders, class_name: 'Order', foreign_key: :billing_address_id
  has_many :shipping_orders, class_name: 'Order', foreign_key: :shipping_address_id

  validates_presence_of :address, :zipcode, :city, :phone, :country
  validates_format_of :zipcode, with: /\A\d{5}\z/
  validates_format_of :phone, with: /\A\d{10}\z/
  validates_associated :country

end
