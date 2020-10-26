class Brand < ApplicationRecord
    has_many :kombuchas, dependent: :destroy

    # --------------------------
    # validations 

    # uncomment below
    # validates :name, presence: true, uniqueness: true 
    #    ^ delete test items w/o brands first! or will break 

    # scope -- uses alpha from kombucha model?
    # scope :alpha --> {order(:name)}
end
