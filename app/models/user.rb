class User < ApplicationRecord
    has_many :reveiws #must come before "through" below, bc we need to tell it that reviews exists first
    has_many :reviewed_kombuchas, through: :reviews, source: :kombucha #how we can 
        # has_many :kombuchas, through: :reviews  # to acceess, do i need to do user.reviews.kombuchas now?

    has_many :kombuchas #that they created
    

    validates :username, uniqueness: true, presence: true # cant have duplicate usernames
    # validates :email, presence: true

    # authentication w/ bcrypt gem
    has_secure_password

    ## google_omniauth 
    # def self.from_omniauth(auth)
    #     where(email: auth.info.email).first_or_initialize do |user|
    #       user.user_name = auth.info.name
    #       user.email = auth.info.email
    #       user.password = SecureRandom.hex
    #     end
    #   end

      

    ## github_omniauth 
end
 

## Both below, are basically just defining a method with the same name like:
    # def kombuchas 
    # end

    #has_many :kombuchas, through: :reviews  
    #has_many :kombuchas 
    