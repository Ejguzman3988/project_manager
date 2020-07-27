class Task < ActiveRecord::Base
    belongs_to :user
    belongs_to :project

    validates :name, 
    length: { maximum: 20}, 
    presence: true, uniqueness: {scope: :project_id}

    validates :description, 
    length: { maximum: 5000}

    validates :user_id, presence: true

    validates :project_id, presence: true
end
