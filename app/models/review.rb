class Review < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :kombucha
  

  # Validations 
  validates :title, presence: true 
  validates :content, presence: true 
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6}
  # uniquness scope determins if user has already reviewed
  validates :kombucha, uniqueness: { scope: :user, message: "has already been reviewed by you"}

 # Methods

 scope :newest_reviewed, -> { order('created_at DESC').limit(3) }

 def date_formatted
  created_at.strftime("%m-%d-%Y")
  # use on - a REVIEW instance - ie: review.date_formatted
  # found in -  Views: users/show, reviews/index, reviews/show
 end 
end
