class ReviewsController < ApplicationController
    def new 
        # find kombucha by id
        # (params[:kombucha_id]) refering to reviews params, not kombuchas
        @kombucha = Kombucha.find_by_id(params[:kombucha_id])
        @review = @kombucha.build_review  # a review belongs_to a kombucha
    end 

    def index 
    end 


    private 

    def review_params 
        params.require(:review).permit(:content, :title, :rating, :kombucha_id)
                #:brand_id, brand_attributes: [:name] 
    end 
end
