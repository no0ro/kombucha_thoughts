class ReviewsController < ApplicationController
    def new 
        # find kombucha by id
        @kombucha = Kombucha.find_by_id(params[:kombucha_id]) # (params[:kombucha_id]) refering to reviews params, not kombuchas
        # ^(params[:kombucha_id]) is specified in form_for hidden field. 
        # 
        @review = @kombucha.reviews.build  # a review belongs_to a kombucha, and kombucha doesnt belong_to a review
        # ^ this review never actually gets saved(aka carry over to create action). it is just the review thats populating the form 
    
    
    end 

    def index 
    end 


    private 

    def review_params 
        params.require(:review).permit(:content, :title, :rating, :kombucha_id)
                #:brand_id, brand_attributes: [:name] 
    end 
end
