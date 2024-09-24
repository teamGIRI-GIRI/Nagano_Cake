class ChangeColumnsOnAddresses < ActiveRecord::Migration[6.1]
  def change
    change_column_null :addresses, :customer_id, false
    change_column_null :addresses, :postal_code, false
    change_column_null :addresses, :address, false
    change_column_null :addresses, :name, false
  end
end
