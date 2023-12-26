class RemoveOrderStatusAndNameFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :order_status_id, :bigint
    # remove_column :orders, :name, :integer
  end
end
