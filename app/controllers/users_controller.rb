class UsersController < ApplicationController
    #before_action :set_user, only: [:show]
    skip_before_action :redirect_if_not_logged_in, only: [:new, :create, :show]
       
    # before_action :require_login

    # user helper method :current_user in create emthod
    # GET /signup 
    def new 
        # Breaks if i remove this.  error in _errors
        @user = User.new
    end 

    # POST /signup
    def create 
        @user = User.new(user_params)
        if @user.save
            # login the user
            session[:user_id] = @user.id #log them in
            redirect_to user_path(@user)
        else 
            render :new
        end 
    end 

    def show 
       
        @some_user = User.find(params[:id])

        if @some_user.id != session[:user_id]
            redirect_to '/' 
            # change this ^^ to be a better redirect
        else 
            @user = current_user  # looks them up by session[:user_id
            #session[:user_id]
        end

        # if !logged_in?
        #     @user = User.find_by_id(params[:id])
        # else
        #     
        # end 
    end 

    private 
    def set_user
        @user = User.find(params[:id])
    end 

    def user_params 
        params.require(:user).permit(:username, :email, :password)
        # .require object, .permit attributes
    end 



    # def require_login
    #     return head(:forbidden) unless session.include? :user_id
    # end 

end
