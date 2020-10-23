class SessionsController < ApplicationController 
    skip_before_action :redirect_if_not_logged_in, only: [:new, :create, :omniauth]
    # skip_before_action only: :create

    # / --> views/welcome.html.erb
    # -> works
    def welcome 
    end 

    # GET /login
    # -> works
    def new 
        # no code not needed here if using form_for :user 
    end

    # POST /login
    # -> works
    def create 
        #byebug
        # does the user exist in our system? 
        @user = User.find_by(username: params[:user][:username]) # find the user in our system via (key: value)
            # ^ this correctly returns SELECT "users".* FROM "users" WHERE "users"."username" = ? LIMIT ?  [["username", "Molly"], ["LIMIT", 1]] (byebug):1:in create <User id: 4, username: "Molly", email: "molly@gmail.com", password_digest: [FILTERED], created_at: "2020-10-21 03:58:10", updated_at: "2020-10-21 03:58:10">

        # once we find the user, ask: 
        # if user exists in system AND the password input matches
        #if @user.try(:authenticate, params[:user][:password])  
            ## --
        #if @user && @user.authenticate(password: params[:user][:password]) 
         #if @user && @user.authenticate(params[:user][:password]) 

        if @user && @user.authenticate(params[:user][:password]) 
            # session[:username] = @user.username
            session[:user_id] = @user.id # set the user id (2) to be saved as the session. store them in our session. this is officially how we say theyre logged in 
                # @user.id == 4 
                # so session[:user_id] will == 4
                    # so calling session[:user_id] inside byebug returns 4
            # flash[:notice] = "You are now logged in"
            redirect_to user_path(@user)
        else
            flash[:error] = "Please try again. Login information is incorrect."
            redirect_to login_path # impt to redirect here! so username isnt persisted
        end
    
    end

    def destroy 
        session.delete(:user_id) 
        # flash[:notice] = "Goodbye"
        puts 'You successfully logged out'
        redirect_to '/'
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