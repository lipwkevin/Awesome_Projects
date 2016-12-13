class Contribute < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user_id,presence: true , uniqueness: {scope: :task_id}
end
