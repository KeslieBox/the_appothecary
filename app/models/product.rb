class Product < ActiveRecord::Base
    belongs_to :user
    has_many :categories_products
    has_many :categories, through: :categories_products
    validates :name, presence: true
    # how to validate uniqueness of name for current user and for Product class?
    # validates_uniqueness_of :name
end



