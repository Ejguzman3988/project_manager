class SessionsController < ApplicationController

    get '/signup' do 
        erb :'/sessions/signup'
    end

    get '/login' do
        erb :'/sessions/login'
    end

    get '/logout' do
        session.clear

        redirect '/'
    end

    post '/signup' do
        
        user = User.new(params[:user])

        if user.save
            if session[:failure_message]
                session[:failure_message] = nil
            end
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            # TODO: Change to flash
            session[:failure_message] = "Enter valid sign up form."

            redirect '/signup'

        end
    end

    post '/login' do
        session[:failure_message] = nil

        user = User.find_by_username(params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect '/users'
        else
            # TODO: Change to flash
            session[:failure_message] = "Enter valid login in form."

            redirect '/login'
        end
        
    end
end