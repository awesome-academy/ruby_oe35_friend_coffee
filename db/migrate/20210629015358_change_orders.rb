class ChangeOrders < ActiveRecord::Migration[6.0]
  def change
    change_table :orders do |t|
      t.rename :subtotal, :order_price
      t.remove :total

      t.references :user, null: false
      t.references(:cart, null: false, type: :bigint)
    end
  end
end
