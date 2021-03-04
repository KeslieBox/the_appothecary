class Product < ActiveRecord::Base
    belongs_to :user

    validates_uniqueness_of(:name)
    validates :name, presence: true
    validates :category, presence: true
end