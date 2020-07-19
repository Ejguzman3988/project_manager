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

        
    get '/users/new' do
        redirect '/signup'
    end

    get '/users/:id' do 
        # TODO: view your profile. 
        if logged_in?
            @user = User.find(params[:id])
            @projects = @user.projects
            erb :'/users/index'
        else
            redirect "/login"
        end
    end

    get '/users/:id/edit' do 
        # TODO: Change name and password and delete.
        if logged_in? && find_user.id == User.find(params[:id])
            erb :'/users/edit'
        else
            flash[:error] = ["Can't edit another users profile"]

            redirect "/users/#{params[:id]"
        end
        
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