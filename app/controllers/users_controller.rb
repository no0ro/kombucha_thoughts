class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
        # ^ necessary bc `before_action :require_login ` in AppController
        # NOTE :current_user  --> in #show 


    # GET /users/:id
    def show 
        # DIY Authorization
        @some_user = User.find(params[:id]) 
        # ^ so users can't access eachothers show page by changing the URL :id

        if @some_user.id != session[:user_id]
            redirect_to '/'    
        else 
            # assign current_user(from AppController) to the instance vari @user
            @user = current_user  # looks them up by session[:user_id]
        end
    end 

    # GET /signup 
    def new 
        @user = User.new
    end 

    # POST /signup
    def create 
        @user = User.new(user_params)

        # .save Authentication
        if @user.save # login the user
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else 
            render :new
        end 
    end 


    private 
    def user_params 
        params.require(:user).permit(:username, :email, :password)
    end 
end
