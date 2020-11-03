class SessionsController < ApplicationController 
    skip_before_action :require_login, only: [:welcome, :new, :create, :omniauth]
        # ^ necessary bc, in App Controller we `before_action :require_login`

    # / (views/welcome.html.erb)
    def welcome 
    end 

    # GET /login
    def new 
    end

    # POST /login
    def create 
        # does the user exist in our system? 
        @user = User.find_by(username: params[:user][:username]) # find the user in our system via (key: value)

        if @user && @user.authenticate(params[:user][:password]) 
            session[:user_id] = @user.id # set the user id (2) to be saved as the session. store them in our session. this is officially how we say theyre logged in 
            # flash[:notice] = "You are now logged in"
            redirect_to user_path(@user)
        else
            flash[:error] = "Please try again. Login information is incorrect."
            redirect_to login_path # impt to redirect here! so username isnt persisted
        end
    
    end

    def destroy 
        session.delete(:user_id) 
        # flash[:notice] = "Goodbye - You successfully logged out" 
        redirect_to '/' # root path
    end 
    
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