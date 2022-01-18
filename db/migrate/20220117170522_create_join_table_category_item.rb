class CreateJoinTableCategoryItem < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :items do |t|
      t.index [:category_id, :item_id]
      t.index [:item_id, :category_id]
    end
  end
end
