class ReviewsController < ApplicationController


    def new 
        # # find kombucha by id
        # @kombucha = Kombucha.find_by_id(params[:kombucha_id]) # (params[:kombucha_id]) refering to reviews params, not kombuchas
        # # ^(params[:kombucha_id]) is specified in form_for hidden field. 
        
        # @review = @kombucha.reviews.build  # a review belongs_to a kombucha, and kombucha doesnt belong_to a review
        # # ^ this review never actually gets saved(aka carry over to create action). it is just the review thats populating the form 
        


        # if nested, aka a :kombucha_id exists, then build review form & associate with this kombucha
        if @kombucha = Kombucha.find_by_id(params[:kombucha_id])
            @review = @kombucha.reviews.build
        else # unnested, display generic form
            @review = Review.new
        end
        
    end 

    def create 
        # one way 
        # @review = Review.new(review_params) # pull from what user just ented
        # @review.user_id = session[:user_id] # assign user to this review

        # if @review.save
        #     redirect_to review_path(@review) # review show page
        # else 
        #     render :new
        # end 



        # better way
        puts "hello1 "
        @current_user = User.find_by_id(session[:user_id]) 
                # @current_user => #<User id: 2, username: "Noelle", email: "noelle@gmail.com", password_digest: [FILTERED], created_at: "2020-09-27 22:40:59", updated_at: "2020-09-27 22:40:59">

        puts "hello2 " 
        #{@current_user}"
        # @review = Review.build 
       
        @review = @current_user.build_review

        if @review.save
            redirect_to review_path(@review)
        else
            render :new
        end
    end 


    def show 
        @review = Review.find_by_id(params[:id])
    end 


    def index
        # if nested, aka :kombucha_id exists 
        if @kombucha = Kombucha.find_by_id(params[:kombucha_id]) 
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
