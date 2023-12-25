class AddOrderStatusToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :order_status, null: false, foreign_key: true
  end
end
