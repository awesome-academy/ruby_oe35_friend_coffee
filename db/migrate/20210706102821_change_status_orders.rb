class ChangeStatusOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :order_status, :integer, default: 0
  end
end
