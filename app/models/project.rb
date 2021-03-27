class Project < ActiveRecord::Base
    has_many :notifications
    has_many :users, through: :notifications
    has_many :tasks

    validates :name, 
    length: { maximum: 20}, 
    presence: true, uniqueness: {scope: :user_id}

    validates :description, 
    length: { maximum: 5000}

    def accepted_users
        accepted_notes = self.notifications.filter{|note| note.join_request == true}
        accepted_notes.map { |note| note.user }
    end
end

