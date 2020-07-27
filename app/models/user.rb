class User < ActiveRecord::Base
    has_many :notifications
    has_many :projects, through: :notifications
    has_many :tasks
    has_secure_password

    validates :name, presence: true, uniqueness: true, length: {maximum: 20}
    validates :username, presence: true, uniqueness: true, length: {maximum: 18}

end
