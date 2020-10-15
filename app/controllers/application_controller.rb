class ApplicationController < ActionController::Base
    helper_method :current_user 
    #  makes the current_user controller method available to the view


    private
    # returns the user that is found by the session id.
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] 
    end 

    #logged_in?


end
