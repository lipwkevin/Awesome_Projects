class CreateContributes < ActiveRecord::Migration[5.0]
  def change
    create_table :contributes do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
