class Task < ActiveRecord::Base
    belongs_to :user
    belongs_to :project

    validates :name, 
    length: { maximum: 20}, 
    presence: true, uniqueness: {scope: :user_id}

    validates :user_id, presence: true

    validates :project_id, presence: true
end
