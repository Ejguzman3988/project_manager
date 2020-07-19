class ProjectsController < ApplicationController
    use Rack::Flash

    get '/projects' do 
        erb :'projects/index'
    end

    get '/projects/new' do 
        erb :'projects/new'
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

    post '/projects/:id' do 
        #TODO: Add helper method to find current project
        erb :'projects/show'
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