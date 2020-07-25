class Project < ActiveRecord::Base
    has_many :notifications
    has_many :users, through: :notifications

    validates :name, 
    length: { maximum: 20}, 
    presence: true, uniqueness: {scope: :user_id}

    validates :description, 
    length: { maximum: 5000}
end

