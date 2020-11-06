class Brand < ApplicationRecord
    # Associations
    has_many :kombuchas, dependent: :destroy
    # Add dependent: :destroy so Kombuchas related to a specific Brand get deleted if the Brand is deleted

    # Validations 
    validates :name, presence: true, uniqueness: true 

    # Scope 
    scope :abc_name, -> { order(:name) }
end
