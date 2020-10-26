class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in

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
        @review = Review.new(review_params) # pull from what user just ented
        @review.user_id = session[:user_id] # assign user to this review

        if @review.save
            redirect_to review_path(@review) # review show page
        else 
            render :new
        end 



        # better way
        # tinkering ------------------
        # puts "hello1 "
        # @current_user = User.find_by_id(session[:user_id]) 
        #         # @current_user => #<User id: 2, username: "Noelle", email: "noelle@gmail.com", password_digest: [FILTERED], created_at: "2020-09-27 22:40:59", updated_at: "2020-09-27 22:40:59">

        # puts "hello2 " 
        #{@current_user}"
        # @review = Review.build 
        # tinkering ------------------


        # @review = current_user.reviews.build(review_params)
        # if @review.save
        #     redirect_to review_path(@review)
        # else
        #     render :new
        # end
    end 


    def show 
        @reviews = Review.find_by_id(params[:id])
        @kombucha = @reviews.kombucha
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

    # GET /reviews/:id/edit
    def edit 
        @review = Review.find_by_id(params[:id])
        # got here from link inside /reviews/16 that only appears if YOU created the review
    end 

     # POST /reviews/:id
     def update 
        @review = Review.find_by_id(params[:id])
        if @review.update(review_params) 
            redirect_to review_path(@review)
            #notice: "Review successfully updated"
        else 
            render :edit
        end 
     end 

    def destroy 
        @review = Review.find(params[:id])
        if @review.present?
            @review.destroy 
            redirect_to reviews_path
        end
    end 




    private 

    def review_params 
        params.require(:review).permit(:kombucha_id, :content, :title, :rating)
                #:brand_id, brand_attributes: [:name] 
    end 
end
