class ChangeDateTimeToDate < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :deadline,  :date
    change_column :goals, :deadline,  :date
    change_column :projects, :deadline,  :date
  end
end
