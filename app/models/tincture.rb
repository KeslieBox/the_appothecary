class Tincture < ActiveRecord::Base
    belongs_to :user
    belongs_to :inventory
end