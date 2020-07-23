class Project < ActiveRecord::Base
    belongs_to :user
    before_validation :autosave_associated_records_for_user
    validates :name, 
    length: { maximum: 20}, 
    presence: true, uniqueness: {scope: :user_id}

    validates :description, 
    length: { maximum: 5000}
end

