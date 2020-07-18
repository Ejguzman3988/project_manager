class User < ActiveRecord::Base
    has_many :projects
    has_secure_password

    validates :name, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
end
