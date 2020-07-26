class NotificationsController < ApplicationController

    get "/projects/:p_id/notifications" do
        @project = find_project(params[:p_id])
        if logged_in? && @project.user_id == current_user.id  
            @notifications = Notification.find_by(user_id: nil, project_id: @project.id)
            erb :'/notifications/index'
        else
            flash[:errors] = ["Only the owner can add people to group."]
        end
    end
end