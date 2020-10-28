class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
        # ^ necessary bc `before_action :require_login ` in AppController
        # NOTE :current_user  --> in #show 


    # GET /signup 
    def new 
        @user = User.new
    end 

    # POST /signup
    def create 
        @user = User.new(user_params)

        if @user.save # login the user
            session[:user_id] = @user.id #log them in
            redirect_to user_path(@user)
        else 
            render :new
        end 
    end 

    # GET /users/:id
    def show 
        @some_user = User.find(params[:id]) 
        # ^ dont want this before_action, bc then if doenst check anything

        if @some_user.id != session[:user_id]
                # notice: "You do Not have access to this users account"
            redirect_to '/' 
                # ERROR: change this ^^ to be a better redirect / Add Error Message
        else # assign current_user(from app_cont.) to the instance vari @user
            @user = current_user  # looks them up by session[:user_id]
        end
    end 

    private 
    def user_params 
        params.require(:user).permit(:username, :email, :password)
    end 
end
