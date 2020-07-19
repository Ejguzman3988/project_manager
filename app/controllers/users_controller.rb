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
        @user = current_user
        profile_user = User.find(params[:id])
        if logged_in? && @user == profile_user
            erb :'/users/edit'
        else
            flash[:errors] = ["Can't edit another users profile"]

            redirect "/users/#{params[:id]}"
        end
        
    end

    get '/users/:id/delete' do
        @user = current_user
        if @user == User.find(params[:id])
            erb :'/users/delete'
        else
            flash[:notice] = ["You CANNOT Delete an account that isn't yours."]
            redirect "/users/#{@user.id}"
        end
    end

    patch '/users/:id' do
        sanitize_params(params)
        user = current_user
        if user.authenticate(params[:user][:old_password]) && user.update(name: params[:user][:name], username: params[:user][:username], password: params[:user][:new_password] )
            redirect "/users/#{params[:id]}"
        else
            redirect "/users/#{params[:id]}/edit"
        end
        
    end

    delete '/users/:id' do
        # TODO: Destroy user.
        if current_user.id == params[:id].to_i
            current_user.destroy
            session.clear
            flash[:notices] = ["Successfully deleted Account."]
            redirect "/"
        else
            flash[:errors] = ["You cannot delete someone elses account"]
            redirect '/users'
        end
    end
end