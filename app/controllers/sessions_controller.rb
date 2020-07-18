class SessionsController < ApplicationController

    get '/signup' do 
        erb :signup
    end

    get '/login' do
        erb :login
    end
end