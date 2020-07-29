class ProjectsController < ApplicationController
    DEFAULT_IMG = "https://cdn01.alison-static.net/public/html/site/img/email/pm-hub-header-img.png"
    
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
            @user = User.find(@project.user_id)
            @notifications = Notification.all.find_all{|note| note.project_id == params[:id].to_i && note.join_request == nil && @project.user_id != note.user_id}
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
            @user = User.find(@project.user_id)
            erb :'projects/edit'
        else
            flash[:errors] = ["You don't have access to edit this project."]
            redirect '/login'
        end  
    end

    post '/projects/:id/join' do
        if logged_in? && !find_project(params[:id]).users.include?(current_user)
            unless find_notification(params[:id])
                notification = current_user.notifications.create(project_id: params[:id])
                flash[:notices] = ["Requested to join project."]
                redirect "/projects/#{params[:id]}"
            else
                flash[:notices] = ["You have already requested to join."]
                redirect "/projects/#{params[:id]}"
            end
        else
            redirect '/login'
        end
    end

    # Adds a valid project to db
    post '/projects' do 
        find_user
        sanitize_params(params)
        if params[:user][:project][:img_link].blank?
            params[:user][:project][:img_link] = DEFAULT_IMG
        end
        params[:user][:project][:user_id] = @user.id
        @project = @user.projects.build(params[:user][:project])

        

        if @user.save
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
        if params[:user][:project][:img_link].blank?
            params[:user][:project][:img_link] = DEFAULT_IMG
        end


        new_project = project.update(
            name: params[:user][:project][:name],
            description: params[:user][:project][:description],  
            img_link: params[:user][:project][:img_link]
        )

        if new_project
            flash[:notices] = ["You have updated your project."]
            redirect "/projects/#{project.id}"
        else
            flash[:errors] = project.errors.full_messages
            redirect "/projects/#{project.id}/edit"
        end
    end

    # Deletes a project
    delete '/projects/:id' do
        project = find_project(params[:id])
        project.notifications.where(project_id: project.id).destroy_all
        project.tasks.where(project_id: project_id).destroy_all
        project.destroy
        
        flash[:notices] = ["You Have successfully deleted project."]
        redirect "/users/#{current_user.id}"
    end
end