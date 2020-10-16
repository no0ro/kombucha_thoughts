class Kombucha < ApplicationRecord
  belongs_to :brand
  belongs_to :user # the creator of it #could rename belongs_to creator
  # ^ gives us all the singular instances 
  has_many :reviews
  has_many :users, through: :reviews #ppl who have reviewed it
  # ^ gives us all the plural instances

  # validations
  validates :flavor, presence: :true
  validate :not_a_duplicate



  # Instance Methods 

  # written as class method - order alphabetically 
  def self.alpha 
    #order('flavor: :asc') 

    order(Arel.sql("#{:flavor} ASC"))

  end 

  # written as scope method 
  


  # brand_attributes (allows 2 versions of Brand to be properly saved to db)
  def brand_attributes=(attributes)
    self.brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
    self.brand  
  end 
 
  accepts_nested_attributes_for :brand
    # this allows the kombucha model to change the Brand by passing a hash key brand_attributes
    # this still be there ???

  
  # same -- validates :kombucha, uniqueness: { scope: :user, message: "has already been reviewed by you"}
  def not_a_duplicate
    # if there is already a kombucha with that flavor && brand, throw an error
    if Kombucha.find_by(flavor: flavor, brand_id: brand_id)
      errors.add(:flavor, "has already been added to that brand")
    end 
  end 

  # for collection_select display in form
  def flavor_and_brand 
    "#{flavor} - #{brand.name}"
     # "#{flavor} - #{brand.try(:name)}"
  end 
 

   
 

  # scope 

  ## alpha -- order or flavors?
 
 


end

