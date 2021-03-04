class User < ActiveRecord::Base
    has_many :herbs
    has_many :products
    has_many :tinctures

    has_secure_password
    validates_uniqueness_of(:username)
end
