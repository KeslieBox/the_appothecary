class User < ActiveRecord::Base
    has_many :inventories
    has_many :herbs
    has_many :products
    has_many :tinctures
end
