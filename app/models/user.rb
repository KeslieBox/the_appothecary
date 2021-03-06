class User < ActiveRecord::Base
    has_many :products
    has_many :categories
   
    has_secure_password
    validates_uniqueness_of(:username)
    validates :email, presence: true
end
