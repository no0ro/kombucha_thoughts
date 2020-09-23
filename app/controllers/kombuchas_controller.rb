class KombuchasController < ApplicationController
    http_basic_authenticate_with name: "noelle", password: "1234", expect: [:index, :show]
# we want to have to authenticate on all the routes EXCEPT for index and show
    # these are the only route you should be able to go to use without having to authenticate (aka public could see)  
    
    # so you cant create a new kombucha, or delete, without logging in 
    def index
        @kombucha = Kombucha.all
    end 

    def show 
        @kombucha = Kombucha.find(params[:id])
    end 

    def new 
        @kombucha = Kombucha.new
    end 

    def create 
        @kombucha = Kombucha.create(kombucha_params) 
        # @kombucha = Kombucha.new(params[:kombucha]) -> doesnt work! 
            # bc need to make private below, and then pass that into .new()

        if(@kombucha.save)
            #&& @kombucha.is_valid?
            redirect_to @kombucha
        else 
            puts "---> didnt save, rendered new again"
            render 'new'
        end 
    end 

    def edit 
    end 

    def update 
    end 

    def destroy 
    end 

    private def kombucha_params 
        params.require(:kombucha).permit(:flavor, :description, :buy_again) 
    end 
end
