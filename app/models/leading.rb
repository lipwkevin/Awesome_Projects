class Leading < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id,presence: true , uniqueness: {scope: :project_id}

  def self.isAdmin(project_id,user)
    return Leading.find_by(project_id: project_id, user:user)
  end
end
