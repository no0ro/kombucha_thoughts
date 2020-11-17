class KombuchasController < ApplicationController
    before_action :set_kombucha, only:[:show, :edit, :update, :destroy]
    before_action :require_login
    
    # GET /kombuchas
    def index
        @kombuchas = Kombucha.order_by_rating.includes(:brand)
    end 

    # GET /kombuchas/1
    def show 
    end 

    # GET /kombuchas/new
    def new 
        @kombucha = Kombucha.new # 1st, .new creates the kombucha instance
        @kombucha.build_brand  # 2nd,  .build creates the brand instance inside of the kombucha form. bc nested form 
            # ^ saves as: name="kombucha[brand_attributes][name]"
            # build syntax: use belongs_to relationship syntax for .build - kombucha belongs to a brand 
    end 

    # POST /kombuchas
    def create 
        @kombucha = Kombucha.new(kombucha_params)
        @kombucha.user_id = session[:user_id] # pulling from the session id,(aka user.id) to then assign that to the creater of this new kombucha
            # kombucha must have something in user_id params for it to pass validations / be created

        if @kombucha.save # where kombucha validations happen
            flash[:notice] =  "Kombucha Successfully Created"
            redirect_to kombucha_path(@kombucha) #, notice: "Kombucha Successfully Created"
        else 
            # build -- @kombucha.build_brand
            render :new 
            # re-render the :new template WITHOUT throwing away the invalid @kombucha
        end 
    end 

    # GET  /kombuchas/1/edit
    def edit 
        # link only appears if YOU created the Kombucha
        # access point: link inside -- kombuchas show,  /kombuchas/1 
    end 

    # PATCH/PUT /kombuchas/1
    def update 
        if @kombucha.update(kombucha_params)
            flash[:notice] =  "Kombucha Successfully Updated"
            redirect_to kombucha_path(@kombucha) #, notice: "Kombucha Successfully Updated"
        else 
            render :edit  # re-render the :edit template WITHOUT throwing away the invalid @kombucha
        end 
    end 

    # DELETE /kombuchas/1
    def destroy 
        @kombucha.destroy 
        redirect_to kombuchas_path #, notice: Kombucha was successfully destroyed. 
    end  


    private 

    # Never trust submitted params, only allow the white list through
    def kombucha_params 
        params.require(:kombucha).permit(:flavor, :description, :brand_id, brand_attributes: [:name]) 
        # MUST pass :brand_id!! or nested Kombucha form will create a new instance with incorrect/incomplete params
    end 

    # Use Callback to share common setup bt actions
    def set_kombucha
         #Find Kombucha by id & save to @instance. 
        @kombucha = Kombucha.find_by(id: params[:id])
        redirect_to kombuchas_path if !@kombucha 
     end
end


