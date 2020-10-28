class BrandsController < ApplicationController 
    before_action :require_login
    
    def index
        @brands = Brand.abc_name
    end 
end
