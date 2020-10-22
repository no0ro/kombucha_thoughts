class ApplicationController < ActionController::Base
    
    #check the session for a user_id, pull the user from the database and save it in @current_user instance variable.
    # Finally write a partial which displays the session user email
    helper_method :current_user, :logged_in?
    #  makes the current_user controller method available to the view


    private

    # returns the user that is found by the session id.
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] 
    end 

    def set_current_user
        @current_user = current_user
    end 

    def logged_in?
        !!session[:user_id]
    end 

    def redirect_if_not_logged_in
        redirect_to login_path if !logged_in?
        
        # if !logged_in?
        #     redirect_to login_path 
        # end 
    end 


end
