class User < ActiveRecord::Base
    has_many :created_projects, foreign_key: "user_id", class_name: "Project"

    has_many :notifications
    has_many :projects, through: :notifications
    has_many :tasks
    has_secure_password

    validates :name, presence: true, length: {maximum: 20}
    validates :username, presence: true, uniqueness: true, length: {maximum: 18}

    def accepted_projects 
        Project.joins(:notifications).where("notifications.user_id = ? and notifications.join_request = true", self.id)
        
    end

    def not_our_notes
        Notification.joins(:project).where("projects.user_id = ? and (notifications.join_request IS NULL or notifications.join_request = false) and notifications.user_id != ?",self1.id,self1.id).select(:project_id, :user_id, :join_request).distinct
    end

end

