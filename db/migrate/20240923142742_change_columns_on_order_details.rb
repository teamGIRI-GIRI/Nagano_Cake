class ChangeColumnsOnOrderDetails < ActiveRecord::Migration[6.1]
  def change
    change_column_null :order_details, :order_id, false
    change_column_null :order_details, :item_id, false
    change_column_null :order_details, :price, false
    change_column_null :order_details, :amount, false
    change_column_null :order_details, :making_status, false
    change_column_default :order_details, :making_status, from: nil, to: "0"
  end
end
