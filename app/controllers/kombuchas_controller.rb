class KombuchasController < ApplicationController
    before_action :set_kombucha, only:[:show, :edit, :update, :destroy]
    before_action :redirect_if_not_logged_in 
    # so you cant create a new kombucha, or delete, without logging in 


    # GET /kombuchas
    def index
        # @kombuchas = Kombucha.all
        @kombuchas = Kombucha.order_by_rating.includes(:brand)
    end 

    # GET /kombuchas/1
    def show 
        # vs .find
        @kombucha = Kombucha.find_by_id(params[:id])
    end 

    # GET /kombuchas/new
    def new 
        @kombucha = Kombucha.new # 1st, create a new instance of Kombucha
        @kombucha.build_brand  # 2nd, bc we have a nested form, we also need to create a new instance of an Brand, and associate that Brand with the Kombucha. this is accomplished with the build method. 
            # ^ saves nested form properly: name="kombucha[brand_attributes][name]" # see model & kombucha new form

        # .new creates the kombucha instance
        # .build creates the brand instance inside of the kombucha form. 

        # the build syntax used here: this is a belongs_to relationship syntax for .build - kombucha belongs to a brand 
    end 

    # POST /kombuchas
    def create 
        @kombucha = Kombucha.new(kombucha_params)
        @kombucha.user_id = session[:user_id] # pulling from the session id,(aka user.id) to then assign that to the creater of this new kombucha
            # assign a user to the params of this newly created kombucha, must do this before we can save the kombucha
        
        if @kombucha.save # where kombucha validations happen
            redirect_to kombucha_path(@kombucha) #showxs
        else 
            # build -- @kombucha.build_brand
            render :new
        end 
    end 

 
    # GET  /kombuchas/1/edit
    def edit 
    end 

    # PATCH/PUT /kombuchas/1
    def update 
        if @kombucha.update(kombucha_params)
            redirect_to kombucha_path(@kombucha)
            #notice: "Kombucha successfully updated"
        else 
            render :edit
        end 
    end 

    # def destroy 
    # must change to dependant: :destry in models. 
    #     @kombucha = Kombucha.find_by(id: params[:id])
    #     @kombucha.destroy 
    #     redirect_to kombuchas_path
    # end  

    private 

    def kombucha_params 
        params.require(:kombucha).permit(:flavor, :description, :buy_again, :brand_id, brand_attributes: [:name]) 
    end 

    def set_kombucha
        @kombucha = Kombucha.find_by(id: params[:id])
        redirect_to kombuchas_path if !@kombucha
     end
end


