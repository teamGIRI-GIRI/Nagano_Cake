class ChangeColumnsOnItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :name, false
    change_column_null :items, :description, false
    change_column_null :items, :genre_id, false
    change_column_null :items, :price, false
    change_column_null :items, :is_active, false
    change_column_default :items, :is_active, from: nil, to: true
  end
end
