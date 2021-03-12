class Product < ActiveRecord::Base
    belongs_to :user
    # has_many :categories
    has_many :categories_products
    has_many :categories, through: :categories_products
    # has_and_belongs_to_many :categories
    validates :name, presence: true
    validates_uniqueness_of :name
end



