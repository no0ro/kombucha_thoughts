class BrandsController < ApplicationController 
    before_action :redirect_if_not_logged_in
    
    def index
        @brands = Brand.abc_name
    end 
end
