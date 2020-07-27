class TasksController < ApplicationController

    get '/tasks' do 
        if logged_in?
            @user = current_user
            @tasks = current_user.tasks
            erb :'tasks/index'
        else
            redirect '/login'
        end
    end

    get '/tasks/:id' do
        @task = Task.find(params[:id])
        @project = find_project(@task.project_id)
        @user = User.find(@task.user_id)
        if logged_in? && @project.users.include?(current_user)
            erb :'tasks/show'
        else
            flash[:errors] = "You don't have access to the project's tasks."
            redirect '/login'
        end
    end

    post '/tasks/:id' do 
        Task.find(params[:id]).update(params[:task])
    end
end