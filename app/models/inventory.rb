class Inventory < ActiveRecord::Base
    has_many :herbs
    has_many :products
    has_many :tinctures
end