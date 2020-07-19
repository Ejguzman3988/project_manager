class UsersController < ApplicationController
    use Rack::Flash

    get '/users' do
        if logged_in?
            find_user
            @projects = @user.projects
            erb :'/users/index'
        else
            redirect '/login'
        end
    end

    get '/users/:id' do 
        # TODO: view your profile. 
        @projects = find_user.projects
        erb :'/users/index'
    end

    get '/users/:id/edit' do 
        # TODO: Change name and password and delete.
        erb :'/users/edit'
    end

    patch '/users/:id' do
        # TODO: Make changes to name and password.
        redirect "/users/#{user.id}"
    end

    delete '/users/:id' do
        # TODO: Destroy user.
        user.destroy
        session.clear
        redirect "/"
    end
end