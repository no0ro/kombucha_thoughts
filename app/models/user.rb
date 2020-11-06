class User < ApplicationRecord
    # Authentication - bcrypt
    has_secure_password 

    # Associations
    has_many :reviews, dependent: :destroy # must come before "through" below, bc we need to tell it that reviews exists first
      # Add dependent: :destroy so reviews related to a specific User get deleted if the Review is deleted
    has_many :reviewed_kombuchas, through: :reviews, source: :kombucha 
        # has_many :kombuchas, through: :reviews  # user.reviews.kombuchas 
    has_many :kombuchas # that they created #users.kombucha

    # Validations
    validates :username, uniqueness: true, presence: true 
    validates :email, uniqueness: true, presence: true


    # OmniAuth

    # login/signup with google omniauth - via EMAIL 
    def self.find_or_create_by_google_omniauth(auth)
        self.find_or_create_by(email: auth[:info][:email]) do |user|
            # set attributes 
            user.password = SecureRandom.hex
            user.username = auth[:info][:name]
        end         
    end 

    # login/signup with github omniauth - via EMAIL
    def self.find_or_create_by_github_omniauth(auth)
        self.find_or_create_by(email: auth[:info][:email]) do |user|
            # set attributes 
            user.password = SecureRandom.hex
            user.username = auth[:extra][:raw_info][:login]
        end   
    end    

 end
