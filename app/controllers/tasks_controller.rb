class TasksController < ApplicationController

    get '/tasks' do
        if logged_in?
            @tasks = current_user.tasks
            erb :'tasks/index'
        else
            redirect '/login'
        end
    end

    get '/users/:id/tasks' do 
        @user = User.find(params[:id])
        if logged_in? && current_user == @user
            @tasks = @user.tasks
            erb :'tasks/index'
        else
            flash[:errors] = ["You don't have access to see these tasks."]
            redirect '/tasks'
        end
    end

    get '/projects/:id/tasks' do
        @project = find_project(params[:id])
        if logged_in? && @project.users.include?(current_user)
            @tasks = @project.tasks
            erb :'tasks/index'
        end
    end

    get '/tasks/:id' do
        @task = Task.find(params[:id])
        @project = find_project(@task.project_id)
        @user = User.find(@task.user_id)
        if logged_in? && @project.users.include?(current_user)
            erb :'tasks/show'
        else
            flash[:errors] = ["You don't have access to the project's tasks."]
            redirect '/login'
        end
    end

    get "/projects/:id/tasks/new" do
        @project = find_project(params[:id])
        if @project.users.include?(current_user)
            erb :'tasks/new'
        end
    end

    get '/tasks/:id/edit' do
        @task = Task.find(params[:id])
        @project = find_project(@task.project_id)
        if logged_in? && (@task.user_id = current_user.id || @project.user_id == current_user.id)
            erb :'tasks/edit'
        else
            flash[:erorrs] = ["You don't have access to project."]
            redirect '/login'
        end
    end

    post '/tasks/:id' do
        task = Task.find(params[:id])
        if task.update(params[:task])
            flash[:notices] = ["Updated"]
            redirect "/tasks/#{params[:id]}"
        else
            flash[:errors] = task.errors.full_messages
            redirect "/tasks/#{params[:id]}"
        end
        
    end

    post '/projects/:id/tasks' do
        task = Task.new(params[:project][:task])
        task.project_id = params[:id]
            
        
        if task.save
            flash[:notices] = ["New Task Created"]
            redirect "/tasks/#{task.id}"
        else
            flash[:errors] = task.errors.full_messages
            redirect "/projects/#{params[:id]}/tasks/new"
        end    
    end

    patch '/tasks/:id' do 
        task = Task.find(params[:id])
        if task.update(params[:project][:task])
            flash[:notices] = ["Updated task"]
            redirect "/tasks/#{params[:id]}"
        else
            flash[:erorrs] = task.errors.full_messages
            redirect "/tasks/#{params[:id]}/edit"
        end
    end
end