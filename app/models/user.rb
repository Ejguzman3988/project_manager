class User < ActiveRecord::Base
    has_many :notifications
    has_many :projects, through: :notifications
    has_many :tasks
    has_secure_password

    validates :name, presence: true, length: {maximum: 20}
    validates :username, presence: true, uniqueness: true, length: {maximum: 18}

    def accepted_projects 
        accepted_notes = self.notifications.filter{|note| note.join_request == 'accept'}
        accepted_notes.map { |note| note.project }

    end

end
