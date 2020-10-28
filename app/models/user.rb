class User < ApplicationRecord
    has_secure_password # authentication w/ bcrypt gem

    # --------------------
    has_many :reviews, dependent: :destroy #must come before "through" below, bc we need to tell it that reviews exists first
      # Add dependent: :destroy so reviews related to a specific User get deleted if the Review is deleted

    
    has_many :reviewed_kombuchas, through: :reviews, source: :kombucha #how we can 
        # has_many :kombuchas, through: :reviews  # to acceess, do i need to do user.reviews.kombuchas now?

    has_many :kombuchas #that they created

    # --------------------
    validates :username, uniqueness: true, presence: true # cant have duplicate usernames
    validates :email, uniqueness: true, presence: true

    # --------------------
    # to login with google omniauth - via EMAIL 
    def self.find_or_create_by_google_omniauth(auth)
        self.find_or_create_by(email: auth[:info][:email]) do |user|
            # set attributes 
            user.password = SecureRandom.hex
            user.username = auth[:info][:name]
        end         
    end 

    # to login with github omniauth - via EMAIL
    def self.find_or_create_by_github_omniauth(auth)
        self.find_or_create_by(email: auth[:info][:email]) do |user|
            # set attributes 
            user.password = SecureRandom.hex
            user.username = auth[:extra][:raw_info][:login]
        end   
    end    

 end
