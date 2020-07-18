class ProjectsController < ApplicationController
    
    get '/projects' do 
        erb :'projects/index'
    end

    get '/projects/new' do 
        erb :'projects/new'
    end

    get '/projects/:id' do 
        erb :'projects/show'
    end

    get '/projects/:id/edit' do
        erb :'projects/edit'
    end

    post '/projects/:id' do 
        #TODO: Add helper method to find current project
        erb :'projects/show'
    end

    patch '/projects/:id' do 
        #TODO: Find project -> Update Project -> Flash: Completed
        
        redirect "/projects/#{project.id}"
    end
end