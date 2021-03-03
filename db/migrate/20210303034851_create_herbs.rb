class CreateHerbs < ActiveRecord::Migration[4.2]
    def change
      create_table :herbs do |t|
        t.string :name
        t.integer :quantity_oz
        t.integer :user_id
      end
    end
end
