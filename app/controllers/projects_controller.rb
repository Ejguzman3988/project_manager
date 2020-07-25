class ProjectsController < ApplicationController
    use Rack::Flash

    # Displays all the projects in the database
    get '/projects' do 
        if logged_in?
            @projects = Project.all
            erb :'projects/index'
            
        else
            flash[:errors] = ["Please log in to view projects"]
            redirect '/login'
        end
    end

    # Provides a form to create a new project
    get '/projects/new' do 
        if logged_in?
            erb :'projects/new'
        else
            flash[:errors] = ["Must be logged in to create new project"]
            redirect '/login'
        end
    end

    # Views a project
    get '/projects/:id' do 
        if logged_in?
            find_project(params[:id])
            erb :'projects/show'
        else
            flash[:errors] = ["Must be logged in to view project."]
            redirect '/login'
        end
    end

    # Provides a form to edit a project
    get '/projects/:id/edit' do
        if logged_in? && current_user.projects.find(params[:id])
            find_project(params[:id])
            erb :'projects/edit'
        else
            flash[:errors] = ["You don't have access to edit this project."]
            redirect '/login'
        end  
    end

    # Adds a valid project to db
    post '/projects' do 
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

    # Updates a valid change to a project
    patch '/projects/:id' do 
        sanitize_params(params)
        project = find_project(params[:id])
        new_project = project.update(
            name: params[:user][:project][:name],
            description: params[:user][:project][:description],  
            img_link: params[:user][:project][:img_link]
        )
        
        if new_project
            flash[:notices] = ["You have updated your project."]
            redirect "/projects/#{project.id}"
        else
            flash[:errors] = ["Project name can't be blank and must be unique. "]
            redirect "/projects/#{project.id}/edit"
        end
    end

    # Deletes a project
    delete '/projects/:id' do
        project = find_project(params[:id])
        project.destroy

        flash[:notices] = ["You Have successfully deleted project."]
        redirect "/users/#{current_user.id}"
    end
end