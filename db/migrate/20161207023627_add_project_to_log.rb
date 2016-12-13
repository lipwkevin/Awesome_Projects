class AddProjectToLog < ActiveRecord::Migration[5.0]
  def change
    add_reference :logs, :project, foreign_key: true
  end
end
