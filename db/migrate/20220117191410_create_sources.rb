class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources do |t|
      t.references :display, null: false, foreign_key: true
      t.references :sourceable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
