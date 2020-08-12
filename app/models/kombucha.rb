class Kombucha < ApplicationRecord
  belongs_to :brand
  belongs_to :user #the creator of it #could rename belongs_to creator
  # ^ gives us all the singular instances 
  has_many :reviews
  has_many :users, through: :reviews #ppl who have reviewed it
  # ^ gives us all the plural instances
end

