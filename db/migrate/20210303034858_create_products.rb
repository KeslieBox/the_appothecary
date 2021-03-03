class CreateProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.string :company
      t.integer :user_id
    end
  end
end
