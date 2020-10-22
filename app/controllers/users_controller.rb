class UsersController < ApplicationController
        before_action :redirect_if_not_logged_in, only: [:show]
        before_action :set_user, only: [:show]
    # before_action :require_login

    # load signup form 
    def new 
        # Breaks if i remove this.  error in _errors
        @user = User.new
    end 

    # signup
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
        redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])
        redirect_to '/' if !@user
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
