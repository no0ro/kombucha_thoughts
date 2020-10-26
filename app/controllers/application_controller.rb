class ApplicationController < ActionController::Base
    
    #check the session for a user_id, pull the user from the database and save it in @current_user instance variable.
    # Finally write a partial which displays the session user email
    before_action :redirect_if_not_logged_in

    helper_method :current_user, :logged_in?
        #  makes the current_user controller method available to the view
        # :logged_in? --> 
        # :current_user --> Users_Controller, 


    private
 
    # returns the user that is found by the session id.
  
    def current_user
        # returns user that is found by session id. only hit db once if instance vari exists
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] 
            # @current_user ||= User.find_by_id(session[:user_id])
    end 

        # # this feels redundent to ^^
        # def set_current_user
        #     @current_user = current_user
        # end 

    def logged_in?
        # (!!) returns everything into boolean 
        !!session[:user_id]
            # (!!current_user)
    end 

    # this is working!! 
    def redirect_if_not_logged_in
        redirect_to login_path if !logged_in?
        
        # if !logged_in?
        #     redirect_to login_path 
        # end 

    end 
end
