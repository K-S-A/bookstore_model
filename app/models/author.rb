class Author < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates_presence_of :firstname, :lastname

end
