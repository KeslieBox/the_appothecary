class CreateInventories < ActiveRecord::Migrations
    def change
        create_table :inventories do |t|
            t.string :herbs 
            t.string :products
            t.string :tinctures
        end
    end
end