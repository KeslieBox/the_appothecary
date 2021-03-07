class Category < ActiveRecord::Base
    # has_many :products
    has_many :categories_products
    has_many :products, through: :categories_products 
    # has_and_belongs_to_many :products

    validates :name, presence: true
end