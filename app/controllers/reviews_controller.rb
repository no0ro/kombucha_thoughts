class ReviewsController < ApplicationController
    before_action :set_review, only:[:show, :edit, :update, :destroy]
    before_action :require_login
   
    # GET /reviews 
    # GET /kombuchas/1/reviews 
    def index

        # if nested, aka :kombucha_id exists 
        if @kombucha = Kombucha.find_by_id(params[:kombucha_id]) 
            @reviews = @kombucha.reviews  # grab all reviews associated with this specific kombucha

        else # unnested, grab all reviews that exist in db
            @reviews = Review.all 
        end 
    end 


    # GET /reviews/new 
    # GET /kombuchas/1/reviews/new 
    def new 
        # if nested, aka a :kombucha_id exists
        if @kombucha = Kombucha.find_by_id(params[:kombucha_id])  # (params[:kombucha_id]) refering to reviews params, not kombuchas #^(params[:kombucha_id]) is specified in form_for hidden field. 
            @review = @kombucha.reviews.build  # build review form & associate with this kombucha ###  # a review belongs_to a kombucha, and kombucha doesnt belong_to a review #this review never actually gets saved(aka carry over to create action). it is just the review thats populating the form  
        else # unnested, display generic form
            @review = Review.new
            # collection_select in form
            # has_many through form
        end
    end 


    # GET /reviews/1
    def show 
        @kombucha = @review.kombucha  # purpose: used in link_to to display Nested index route (kombuchas/1/reviews)
    end 


    # POST /reviews
    def create 
        @review = Review.new(review_params) # pull from what user just entered
        @review.user_id = session[:user_id] # assign user to this review

        if @review.save
            flash[:notice] = "Review Successfully Created"
            redirect_to review_path(@review) # review show page  #, notice: "Review Successfully Created"
        else 
            render :new
        end 
    end 


    # GET /reviews/1/edit
    def edit 
       # access point: users show page
       # access point: link inside -- reviews show,  /reviews/1 
             # link only appears if YOU created the review
    end 


    # PATCH/PUT /reviews/1
    def update 
        if @review.update(review_params) 
            flash[:notice] = "Review Successfully Updated"
            redirect_to review_path(@review)#, notice: "Review Successfully Updated" 
        else 
            render :edit
        end 
    end 

    # /reviews/newest_reviewed
    def newest_reviewed
        @reviews = Review.newest_reviewed

    end 

    # /reviews/most_reviews
    def most_reviews
        @review = Review.most_reviews 
        @kombucha = Kombucha.find_by_id(@review.kombucha_id)
            # added @kombucha to easically get the total number of reviews it has
    end 

    # DELETE /reviews/1 
    def destroy 
        if @review.present? #necessary?
            @review.destroy 
            redirect_to reviews_path #, notice: Kombucha was successfully destroyed. 
        end
    end 



    private 

    def review_params 
        params.require(:review).permit(:kombucha_id, :content, :title, :rating)

    end 

    def set_review
        @review = Review.find_by(id: params[:id])
        redirect_to reviews_path if !@review
    end  
end
