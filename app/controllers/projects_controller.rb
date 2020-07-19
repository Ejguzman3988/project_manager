class ProjectsController < ApplicationController
    use Rack::Flash

    get '/projects' do 
        if logged_in?
            @projects = Project.all
            erb :'projects/index'
        else
            flash[:errors] = ["Please log in to view projects"]
            redirect '/login'
        end
    end

    get '/projects/new' do 
        if logged_in?
            erb :'projects/new'
        else
            flash[:errors] = ["Must be logged in to create new project"]
            redirect '/login'
        end
        

        
    end

    get '/projects/:id' do 
        if logged_in?
            find_project(params[:id])
            erb :'projects/show'
        else
            redirect '/login'
        end
        
    end

    get '/projects/:id/edit' do
        find_project(params[:id])
        erb :'projects/edit'
    end

    post '/projects' do 
        #TODO: Add helper method to find current project
        find_user
        sanitize_params(params)
        @project = @user.projects.build(params[:user][:project])
        if @project.save
            flash[:notices] = ["successfully created project"]
            redirect "/projects/#{@project.id}"
        else
            flash[:errors] = @project.errors.full_messages
            redirect "/projects/new"
        end
    end

    patch '/projects/:id' do 
        #TODO: Find project -> Update Project -> Flash: Completed
        sanitize_params(params)
        project = find_project(params[:id])
        project.update(name: params[:user][:project][:name], description: params[:user][:project][:description],  img_link: params[:user][:project][:img_link])

        redirect "/projects/#{project.id}"
    end

    delete '/projects/:id' do
        project = find_project(params[:id])
        project.destroy

        flash[:notices] = ["You Have successfully deleted project."]
        redirect "/users/#{current_user.id} "
    end
end