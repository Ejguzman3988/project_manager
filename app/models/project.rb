class Project < ActiveRecord::Base
    belongs_to :user
    before_validation :autosave_associated_records_for_user
    validates :name, presence: true, uniqueness: {scope: :user_id}
    # Name LIMIT: 23
    # Description LIMIT :1000
    # img_link LIMIT?
end

