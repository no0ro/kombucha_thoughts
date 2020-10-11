class ReviewsController < ApplicationController
    def new 
        # find kombucha by id
        @kombucha = Kombucha.find_by_id(params[:kombucha_id]) # (params[:kombucha_id]) refering to reviews params, not kombuchas
        # ^(params[:kombucha_id]) is specified in form_for hidden field. 
        
        @review = @kombucha.reviews.build  # a review belongs_to a kombucha, and kombucha doesnt belong_to a review
        # ^ this review never actually gets saved(aka carry over to create action). it is just the review thats populating the form 
        
        # @review = Review.new
    end 

    def create 
        # one way 
        @review = Review.new(review_params) # pull from what user just ented
        @review.user_id = session[:user_id] # assign user to this review

        if @review.save
            redirect_to review_path(@review) # review show page
        else 
            render :new
        end 

        # better way

        # @review = current_user.reviews.build(review_params)
        # if @review.save
        #     redirect_to review_path(@review)
        # else
        #     render :new
        # end

    end 

    def show 
        @review = Review.find_by_id(params[:id])
    end 


    def index
        # if nested, aka :kombucha_id exists 
        if 
            @kombucha = Kombucha.find_by_id(params[:kombucha_id]) 
                # where - grab all reviews associated with this specific kombucha
            @reviews = @kombucha.reviews

        else 
        # else unnested 
            @reviews = Review.all
        end 
    end 




    private 

    def review_params 
        params.require(:review).permit(:kombucha_id, :content, :title, :rating)
                #:brand_id, brand_attributes: [:name] 
    end 
end
