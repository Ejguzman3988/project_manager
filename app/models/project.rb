class Project < ActiveRecord::Base
    has_many :notifications
    has_many :users, through: :notifications
    has_many :tasks

    validates :name, 
    length: { maximum: 20}, 
    presence: true, uniqueness: {scope: :user_id}

    validates :description, 
    length: { maximum: 5000}
    
    def self.search(query)
        Project.where("projects.name = ?", query)
    end

    def accepted_users
        User.joins(:notifications).where("notifications.project_id = ? and notifications.join_request = true", self.id)
    end
end

