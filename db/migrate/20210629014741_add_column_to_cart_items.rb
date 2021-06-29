class AddColumnToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :unit_price, :decimal
    add_column :cart_items, :total, :decimal
    add_column :cart_items, :category_id, :integer
  end
end
