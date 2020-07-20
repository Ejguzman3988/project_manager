class SessionsController < ApplicationController
    use Rack::Flash
    
    # Provides form for user to sign up
    get '/signup' do 
        if logged_in?
            redirect '/users'
        else
            erb :'/sessions/signup'
        end
    end

    # Provides form for user to log in
    get '/login' do
        if logged_in?
            redirect "/users/#{current_user.id}"
        else
            erb :'/sessions/login'
        end
    end

    # Allows user to log out
    get '/logout' do
        session.clear
        if logged_in?
            flash[:notices] = ["Successfully logged out."] 
        end
        redirect '/'
    end

    # Adds a valid user into the db
    post '/signup' do
        sanitize_params(params)
        user = User.new(params[:user])

        if user.save
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            if User.find_by_username(params[:user][:username]) && !params[:user][:password].blank? && !params[:user][:name].blank? 
                flash[:errors] = ["Username is not unique."] 
            else
                flash[:errors] = user.errors.full_messages
            end
            
            redirect '/signup'

        end
    end

    # Logs in a user with the correct credentials
    post '/login' do
        sanitize_params(params)
        user = User.find_by_username(params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            flash[:errors] = ["Invalid Username and Password."]
            redirect '/login'
        end
    end
end