class User < ApplicationRecord
    has_many :reveiws #must come before "through" below, bc we need to tell it that reviews exists first
    has_many :kombuchas, through: :reviews 

    has_many :kombuchas #that they created
end
 