class NotificationsController < ApplicationController

    get "/notifications" do
        if logged_in?
            find_user
            @notifications = []
            @user.projects.each do |project|
                notify = project.notifications.where(user_id: nil)
                unless notify.empty?
                    @notifications << notify
                end
            end
            @notifications = @notifications.flatten


            erb :'/notifications/index'
        else
            flash[:error] = ["Please Login to view your notifications."]
            redirect '/login'
        end
    end

    post '/notifications/:id/accept' do
        notification = Notification.find(params[:id])
        notification.user_id = notification.join_request.to_i
        notification.join_request = nil
        notification.save
        flash[:notices] = ["#{User.find(notification.user_id).username} has been added to your project."]
        redirect "/projects/#{notification.project_id}"
    end

    post '/notifications/:id/decline' do
        notification = Notification.find(params[:id])
        if notification.user_id.nil?
            flash[:notices] = ["#{User.find(notification.join_request.to_i).username} has NOT been added to your project."]  
        else
            flash[:notices] = ["#{User.find(notification.user_id).username} has been kicked."]  
        end
        notification.delete
        redirect "/projects/#{notification.project_id}"
    end
end