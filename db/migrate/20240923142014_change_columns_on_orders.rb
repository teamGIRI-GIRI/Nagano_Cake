class ChangeColumnsOnOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_null :orders, :customer_id, false
    change_column_null :orders, :postal_code, false
    change_column_null :orders, :address, false
    change_column_null :orders, :name, false
    change_column_null :orders, :shipping_cost, false
    change_column_null :orders, :total_payment, false
    change_column_null :orders, :payment_method, false
    change_column_null :orders, :status, false
    change_column_default :orders, :status, from: nil, to: "0"
  end
end
