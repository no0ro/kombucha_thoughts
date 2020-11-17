class SessionsController < ApplicationController 
    skip_before_action :require_login, only: [:welcome, :new, :create, :omniauth]
        # ^ necessary bc, in App Controller we `before_action :require_login`

    # '/' 
    def welcome 
    end 

    # GET /login
    def new 
    end

    # POST /login
    def create 
        # does the user exist in our system? 
        @user = User.find_by(username: params[:user][:username]) # find the user via (key: value)

        # Authentication confirms that users are who they say they are.
        if @user && @user.authenticate(params[:user][:password]) 
            session[:user_id] = @user.id # login user in 
            redirect_to user_path(@user)
        else
            flash[:error] = "Please try again. Login information is incorrect."
            redirect_to login_path # impt to redirect here! so username isn't persisted # Redirect sends the browser to a different URL, but since this is the same page, it just clears the form

        end
    end


    def destroy 
        session.delete(:user_id) 
        redirect_to '/' # root path aka _loggout_links
    end 
    
    # 3rd Party API authentication
    def omniauth
        if params[:provider] == 'github'
            @user = User.find_or_create_by_github_omniauth(auth)
        else 
            @user = User.find_or_create_by_google_omniauth(auth)
        end

        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end 

  
    private  

    # returns omniauth user hash 
    def auth
        request.env['omniauth.auth']
    end
end  