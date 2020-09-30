class KombuchasController < ApplicationController
    #http_basic_authenticate_with name: "noelle", password: "1234", expect: [:index, :show]
# we want to have to authenticate on all the routes EXCEPT for index and show
    # these are the only route you should be able to go to use without having to authenticate (aka public could see)  
    
    # so you cant create a new kombucha, or delete, without logging in 
    def index
        @kombuchas = Kombucha.all
    end 

    def show 
        @kombucha = Kombucha.find(params[:id])
    end 

    def new 
        @kombucha = Kombucha.new
        @kombucha.build_brand  # saves nested form properly: name="kombucha[brand_attributes][name]" # see model & kombucha new form
    end 

    # def create 
    #     @kombucha = Kombucha.create(kombucha_params) 
    #     # @kombucha = Kombucha.new(params[:kombucha]) -> doesnt work! 
    #         # bc need to make private below, and then pass that into .new()

    #     if(@kombucha.save)
    #         #&& @kombucha.is_valid?
    #         redirect_to @kombucha
    #     else 
    #         puts "---> didnt save, rendered new again"
    #         render 'new'
    #     end 
    # end 

    def create 
        @kombucha = Kombucha.new(kombucha_params)
        @kombucha.user_id = session[:user_id] # pulling from the session id,(aka user.id) to then assign that to the creater of this new kombucha
            # assign a user to the params of this newly created kombucha, must do this before we can save the kombucha
        if @kombucha.save # where kombucha validations happen
            redirect_to kombucha_path(@kombucha) #showxs
        else 
            # build
            render :new
        end 
    end 

    def edit 
    end 

    def update 
    end 

    def destroy 
    end  

    private 

    def kombucha_params 
        params.require(:kombucha).permit(:flavor, :description, :buy_again, :brand_id, brand_attributes: [:name]) 
    end 
end
