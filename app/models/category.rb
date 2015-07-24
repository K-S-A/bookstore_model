class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates_presence_of :title
  validates_uniqueness_of :title, case_sensitive: false

end
