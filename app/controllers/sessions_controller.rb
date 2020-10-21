class SessionsController < ApplicationController 

    def welcome 
    end 

    def destroy 
        session.delete(:user_id)
        redirect_to '/'
    end 

    def new
    end
    
    def create 
        # does the user exist in our system? 
        @user = User.find_by(username: params[:username]) # find the user in our system via (key: value)
        # @user = User.find_by(username: params[:user][:username]) # find the user in our system via (key: value)
        

        # once we find the user, ask: 
        # if user exists in system AND the password input matches
        #if @user.try(:authenticate, params[:user][:password])  
            ## --
        if @user && @user.authenticate(password: params[:user][:password]) 
            session[:user_id] = @user.id # set the user id (2) to be saved as the session. store them in our session. this is officially how we say theyre logged in 
            redirect_to user_path(@user)
        ## elseif
        else
            flash[:error] = "Please try again. Login information is incorrect."
            redirect_to login_path # impt to redirect here! so username isnt persisted
        end
    
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