class KombuchasController < ApplicationController

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
        if(@kombucha.save)
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
