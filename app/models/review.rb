class Review < ApplicationRecord
  belongs_to :user
  belongs_to :kombucha
  
  # --------------------
  # validates 
  validates :title, presence: true 
  validates :content, presence: true 
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6}
 
  # validatios: use titlecase 

  # validate kombucha and our uniquness scope determins if user has already reviewed
  validates :kombucha, uniqueness: { scope: :user, message: "has already been reviewed by you"}

  # validates: , uniqueness: {scope :name, -> { where(:attibute => value)}
  # Ex:- scope :active, -> {where(:active => true)}}

end
