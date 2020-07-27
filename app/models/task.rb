class Task < ActiveRecord::Base
    belongs_to :user
    belongs_to :project

    validates :name, 
    length: { maximum: 20}, 
    presence: true, uniqueness: {scope: :user_id}
end
