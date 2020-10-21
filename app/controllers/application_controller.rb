class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    # #  makes the current_user controller method available to the view


     private

    # # returns the user that is found by the session id.
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] 
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
