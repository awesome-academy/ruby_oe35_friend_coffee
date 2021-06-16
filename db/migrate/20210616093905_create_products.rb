class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :old_price
      t.integer :price
      t.text :information
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
