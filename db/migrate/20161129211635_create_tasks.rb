class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :deadline
      t.references :goal, foreign_key: true
      t.boolean :completed
      t.boolean :flagged

      t.timestamps
    end
  end
end
