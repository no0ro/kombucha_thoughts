class KombuchasController < ApplicationController

    def index
        @kombucha = Kombucha.all
    end 

    def show 
    end 

    def new 
        @kombucha = Kombucha.new
    end 

    def create 
        @kombucha = Kombucha.create(kombucha_params)
    end 

    def edit 
    end 

    def update 
    end 

    def destroy 
    end 
end
