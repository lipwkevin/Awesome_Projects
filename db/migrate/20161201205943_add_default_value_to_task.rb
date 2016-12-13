class AddDefaultValueToTask < ActiveRecord::Migration[5.0]
  def change
    change_column_default :tasks, :completed, false
    change_column_default :tasks, :flagged, false
  end
end
