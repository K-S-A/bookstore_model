class Country < ActiveRecord::Base
  has_many :addresses, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_inclusion_of :name, in: Carmen::Country.all.map(&:name)

end
