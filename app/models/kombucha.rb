class Kombucha < ApplicationRecord
  # Associations
  belongs_to :brand
  belongs_to :user # the creator of it #users.kombucha #gives us all the singular instances 
  has_many :reviews, dependent: :destroy # Add dependent: :destroy so Reviews related to a specific Kombucha get deleted if the Review is deleted
  has_many :users, through: :reviews # Users who reviewed that Kombucha  #gives us all the plural instances

  # Validations
  validates :flavor, presence: :true
  validates :description, presence: :true 

  # Custom Validations
  validate :not_a_duplicate

  # same as -- validates :kombucha, uniqueness: { scope: :user, message: "has already been reviewed by you"}
  def not_a_duplicate
    # if there is already a kombucha with that flavor && brand, throw an error
    kombucha = Kombucha.find_by(flavor: flavor, brand_id: brand_id)
    if !!kombucha && kombucha != self 
      # if statement necessary so we can update
      errors.add(:flavor, "has already been added to that brand")
    end 
  end 

  # Methods 
  # brand_attributes (allows 2 versions of Brand to be properly saved to db)
  def brand_attributes=(attributes)
    self.brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
    self.brand  
  end 

  def self.abc_name
    order(:flavor) 
  end 
    # written as class method - different way to write ~~>  `scope :abc_name, -> { order(:flavor) }`
    # order alphabetically 
    # --> reviews/new view, but on the Kombucha class 

  
  def flavor_and_brand
    "#{flavor} - #{brand.name}"  
  end 
  # --> /reviews/new, collection_select display 
 
  def brand_and_flavor 
    "#{brand.name} -  #{flavor}"  
  end 


  # Scope
  scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(rating) desc')}
  # --> used in KombController#index
 
 




end