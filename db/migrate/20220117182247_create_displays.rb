class CreateDisplays < ActiveRecord::Migration[7.0]
  def change
    create_table :displays do |t|
      t.references :user
      t.references :dashboard, null: false, foreign_key: true
      t.integer :type
      t.string :name

      t.timestamps
    end
  end
end
