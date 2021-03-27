class NotificationsController < ApplicationController

    get "/notifications" do
        if logged_in?
            current_user
            # @notifications = []
          
                # current_user.projects.each do |project|
                #     if current_user.projects.inlcude?(project)
                #         @notifications << project.notifications.find_all{|note| note.user_id != @user.id && note.join_request == nil}
                #     end
            # en

            # @notifications = @notifications.flatten
            @notifications = current_user.notifications


            erb :'/notifications/index'
        else
            flash[:error] = ["Please Login to view your notifications."]
            redirect '/login'
        end
    end

    post '/notifications/:id/accept' do
        notification = Notification.find(params[:id])
        notification.join_request = true
        notification.save
        flash[:notices] = ["#{User.find(notification.user_id).username} has been added to your project."]
        redirect "/projects/#{notification.project_id}"
    end

    post '/notifications/:id/decline' do
        notification = Notification.find(params[:id])
        flash[:notices] = ["#{User.find(notification.user_id).username} has NOT been added to your project."]  

        notification.delete
        redirect "/projects/#{notification.project_id}"
    end
    
    delete '/notifications/:id' do
        notification = Notification.find(params[:id])

        redirect_id = notification.project_id

        flash[:notices] = ["#{User.find(notification.user_id).username} has been kicked."]  
        notification.delete
        redirect "/projects/#{redirect_id}"
    end


end