class Review < ApplicationRecord
  belongs_to :user
  belongs_to :kombucha

  #validates 
  validates :title, presence: true 
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6}



  #ice_cream (if already been reviewed aka uniqueness)
end
