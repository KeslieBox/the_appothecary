class Product < ActiveRecord::Base
    belongs_to :user
    has_many :categories

    validates :name, presence: true
end



