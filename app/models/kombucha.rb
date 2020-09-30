class Kombucha < ApplicationRecord
  belongs_to :brand
  belongs_to :user #the creator of it #could rename belongs_to creator
  # ^ gives us all the singular instances 
  has_many :reviews
  has_many :users, through: :reviews #ppl who have reviewed it
  # ^ gives us all the plural instances

   ## brand_attributes (allows 2 versions of Brand to be properly saved to db)
  def brand_attributes=(attributes)
    self.brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
    self.brand  
  end 
 
  accepts_nested_attributes_for :brand

  # validations 

  # scope 

  # methods
  ## alpha -- order or flavors?
 
  ## # if there is already an ice cream with that flavor && brand, throw an error


end

