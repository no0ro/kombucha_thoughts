class Review < ApplicationRecord
  belongs_to :user
  belongs_to :kombucha

  #validates 
  ## title, rating, ice_cream (if already been reviewed aka uniqueness)
end
