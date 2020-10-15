class Kombucha < ApplicationRecord
  belongs_to :brand
  belongs_to :user #the creator of it #could rename belongs_to creator
  # ^ gives us all the singular instances 
  has_many :reviews
  has_many :users, through: :reviews #ppl who have reviewed it
  # ^ gives us all the plural instances


  validates :flavor, presence :true


  # brand_attributes (allows 2 versions of Brand to be properly saved to db)
  def brand_attributes=(attributes)
    self.brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
    self.brand  
  end 
 
  accepts_nested_attributes_for :brand
    # this allows the kombucha model to change the Brand by passing a hash key brand_attributes
    # this still be there ???



  # validations 
 

  # scope 

  ## alpha -- order or flavors?
 
 


end

