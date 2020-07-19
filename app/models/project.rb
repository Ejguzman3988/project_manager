class Project < ActiveRecord::Base
    belongs_to :user
    before_validation :autosave_associated_records_for_user
    validates :name, presence: true, uniqueness: {scope: :user_id}
end
