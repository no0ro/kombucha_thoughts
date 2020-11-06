class ApplicationController < ActionController::Base
    before_action :require_login
    # ^ check the session for a user_id, pull the user from the db & save it in @current_user instance variable.
    helper_method :current_user, :logged_in?
    # :current_user --> Users_Controller#create, Views/Layouts/application.html.erb
    # :logged_in? --> Helpers/application_helper.rb 


    private
 
    def logged_in?
        !!session[:user_id] # aka !!current_user
    end 

    def require_login
        if !logged_in?
            redirect_to login_path 
        end 
    end 


    # returns the user that is found by the session id
    def current_user
        if session[:user_id] # if there is a session_id present (aka someone's logged in) 
            @current_user ||= User.find_by_id(session[:user_id])
                # find that User object, and save it in the instance variable @current_user
                # || useful bc then only hit db once if instance vari exists
        end 
    end 
end

