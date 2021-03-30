class NotificationsController < ApplicationController

    get "/notifications" do
        if logged_in?
            @notifications = current_user.not_our_notes


            erb :'/notifications/index'
        else
            flash[:error] = ["Please Login to view your notifications."]
            redirect '/login'
        end
    end

    post '/notifications/:id/accept' do
        notification = Notification.find(params[:id])
        notification.join_request = true
        if notification.save
            flash[:notices] = ["#{User.find(notification.user_id).username} has been added to your project."]
        else
            flash[:notices] = notification.erors.full_messages
        end
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