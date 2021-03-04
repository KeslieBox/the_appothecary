class CreateProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.integer :inventory
      t.integer :cost_of_good
      t.integer :retail_price
      t.string :source
      t.integer :user_id
    end
  end
end
