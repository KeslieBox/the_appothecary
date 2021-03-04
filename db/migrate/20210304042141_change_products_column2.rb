class ChangeProductsColumn2 < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :retail_price, :float
  end
end
