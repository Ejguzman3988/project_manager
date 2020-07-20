class UsersController < ApplicationController
    use Rack::Flash

    # TODO: Change to show generic user profile?/ create a new index page
    # Shows all of users projects
    get '/users' do
        if logged_in?
            find_user
            @projects = @user.projects
            erb :'/users/show' 
        else
            redirect '/login'
        end
    end

    # Redirects to a sign up form
    get '/users/new' do
        redirect '/signup'
    end

    # Shows all of specified users projects
    get '/users/:id' do 
        # TODO: view your profile. 
        if logged_in?
            @user = User.find(params[:id])
            @projects = @user.projects
            erb :'/users/show'
        else
            redirect "/login"
        end
    end

    # Form to edit currently logged on user
    get '/users/:id/edit' do 
        # TODO: Change name and password and delete.
        @user = current_user
        profile_user = User.find(params[:id])
        if logged_in? && @user == profile_user
            erb :'/users/edit'
        else
            flash[:errors] = ["Can't edit another users profile"]

            redirect "/users/#{params[:id]}"
        end
        
    end

    # Updates the user by given specifications
    patch '/users/:id' do
        sanitize_params(params)
        user = current_user
        if user.authenticate(params[:user][:old_password]) && user.update(name: params[:user][:name], username: params[:user][:username], password: params[:user][:new_password] )
            redirect "/users/#{params[:id]}"
        else
            redirect "/users/#{params[:id]}/edit"
        end
        
    end

    # deletes a user and its projects
    delete '/users/:id' do
        user = current_user
        if user.id == params[:id].to_i
            user.projects.each do |project|
                project.delete
            end
            user.delete
            session.clear
            flash[:notices] = ["Successfully deleted Account."]
            redirect "/"
        else
            flash[:errors] = ["You cannot delete someone elses account"]
            redirect '/users'
        end
    end
end