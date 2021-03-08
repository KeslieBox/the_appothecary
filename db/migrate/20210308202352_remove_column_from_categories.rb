class RemoveColumnFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :user_id
  end
end
