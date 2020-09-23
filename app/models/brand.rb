class Brand < ApplicationRecord
    has_many :kombuchas

    # validations 
    # scope -- uses alpha from kombucha model?
end
