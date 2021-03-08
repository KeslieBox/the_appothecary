class User < ActiveRecord::Base
    has_many :products
    has_many :categories, through: :products
   
    has_secure_password
    validates :password, length: { minimum: 5 }, if: :password_digest_changed?
    validates_uniqueness_of(:username)
    validates :email, presence: true
end
