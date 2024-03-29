class UsersController < ApplicationController
    use Rack::Flash

    # TODO: Change to show generic user profile?/ create a new index page
    # Shows all of users projects
    get '/users' do
        @user = current_user
        if logged_in?
            @all_projects ||= current_user.created_projects
            @page = params[:page].to_i
            if @page > 0
                @projects = Project.pagination(@all_projects, @page)
            else
                @page = 1
                @projects = Project.pagination(@all_projects)
            
            end
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
        if logged_in?
            @user = User.find(params[:id])
            @all_projects ||= @user.created_projects
            @page = params[:page].to_i
            if @page > 0
                @projects = Project.pagination(@all_projects, @page)
            else
                @page = 1
                @projects = Project.pagination(@all_projects)
            
            end
            erb :'/users/show' 
        else
            redirect '/login'
        end
    end

    # Form to edit currently logged on user
    get '/users/:id/edit' do 
        @user = User.find(params[:id])
        if logged_in? && current_user == @user
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
        test_user = User.new(password: params[:user][:new_password])
        test_user.valid? 
        new_password_error_message = test_user.errors.full_messages_for(:password).join

        if user.authenticate(params[:user][:old_password])
            if user.update(name: params[:user][:name], username: params[:user][:username], password: params[:user][:new_password]) &&  new_password_error_message.blank?
                flash[:notices] = ["Your user profile has been saved."]
                redirect "/users/#{params[:id]}"
            else
                flash[:errors] = user.errors.full_messages
                flash[:errors] << new_password_error_message
            end
        else
            flash[:errors] = ["Incorrect password"]
        end

        redirect "/users/#{params[:id]}/edit"
        
    end

    # deletes a user and its projects
    delete '/users/:id' do
        user = current_user
        if user.id == params[:id].to_i
            user.projects.where(user_id: user.id).destroy_all
            user.notifications.where(user_id: user.id).destroy_all
            user.notifications.where(join_request: user.id).destroy_all
            user.tasks.where(user_id: user.id).destroy_all
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