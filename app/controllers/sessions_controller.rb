class SessionsController < ApplicationController

    get '/signup' do 
        erb :'/sessions/signup'
    end

    get '/login' do
        erb :'/sessions/login'
    end

    post '/signup' do
        
        user = User.new(params[:user])

        if user.save
            if session[:failure_message]
                session[:failure_message] = nil
            end
            redirect "/users/#{user.id}"
        else
            # Change to flash
            session[:failure_message] = "Enter valid sign up form."

            redirect '/signup'

        end
    end
end