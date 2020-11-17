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

 scope :most_reviews, -> {joins(:kombucha).group('reviews.kombucha_id').order("count(reviews.kombucha_id) desc").first}
 # RETURNS => #<Review id: 10, content: "Yummy I love this!", title: "Love", rating: 5, user_id: 4, kombucha_id: 2, created_at: "2020-10-21 18:37:33", updated_at: "2020-11-10 19:19:53">

 scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(rating) desc')}


 def date_formatted
  created_at.strftime("%m-%d-%Y")
  # use on - a REVIEW instance - ie: review.date_formatted
  # found in -  Views: users/show, reviews/index, reviews/show
 end 
end
