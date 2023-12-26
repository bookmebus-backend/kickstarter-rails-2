class UpdateOrderField < ActiveRecord::Migration[7.1]
  def change
    execute <<~SQL
      UPDATE orders
      SET order_status_id = (
        CASE
          WHEN status = 0 THEN (SELECT id FROM order_statuses WHERE name = 'pending')
          WHEN status = 1 THEN (SELECT id FROM order_statuses WHERE name = 'completed')
          WHEN status = 2 THEN (SELECT id FROM order_statuses WHERE name = 'cancel')
          ELSE NULL
        END
      )
    SQL
  end
end
