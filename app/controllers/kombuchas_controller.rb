class KombuchasController < ApplicationController

    # so you cant create a new kombucha, or delete, without logging in 
 
    def new 
        @kombucha = Kombucha.new # 1st, create a new instance of Kombucha
        @kombucha.build_brand  # 2nd, bc we have a nested form, we also need to create a new instance of an Brand, and associate that Brand with the Kombucha. this is accomplished with the build method. 
            # ^ saves nested form properly: name="kombucha[brand_attributes][name]" # see model & kombucha new form

        # .new creates the kombucha instance
        # .build creates the brand instance inside of the kombucha form. 

        # the build syntax used here: this is a belongs_to relationship syntax for .build - kombucha belongs to a brand 
    end 

    
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

    def index
        @kombuchas = Kombucha.all
    end 

    def show 
        # vs .find
        @kombucha = Kombucha.find_by_id(params[:id])
    end 

    def edit 
    end 

    def update 
    end 

    # def destroy 
    # end  

    private 

    def kombucha_params 
        params.require(:kombucha).permit(:flavor, :description, :buy_again, :brand_id, brand_attributes: [:name]) 
    end 
end
