class ChangeProductsColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :cost_of_good, :float
  end
end
