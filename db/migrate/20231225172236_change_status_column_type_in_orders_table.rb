class ChangeStatusColumnTypeInOrdersTable < ActiveRecord::Migration[7.1]
  def change
    execute 'ALTER TABLE orders ALTER COLUMN status TYPE integer USING CAST(status AS integer)'
  end
end
