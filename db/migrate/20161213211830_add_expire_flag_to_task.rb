class AddExpireFlagToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :expired, :boolean, default:false
  end
end
