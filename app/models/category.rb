class Category < ActiveRecord::Base
    
    has_many :categories_products
    has_many :products, through: :categories_products 

    validates :name, presence: true
end