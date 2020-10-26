class Brand < ApplicationRecord
    has_many :kombuchas, dependent: :destroy

    # --------------------------
    # validations 
    validates :name, presence: true, uniqueness: true 
        #    ^ delete test items w/o brands first! or will break 
        # uniqueness??
    
    # scope -- uses abc from kombucha model?
    scope :abc_name, -> { order(:name) }
end
