class RenameProductsColumn2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :kind, :category
  end
end
