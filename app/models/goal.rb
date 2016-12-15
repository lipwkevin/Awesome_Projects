class Goal < ApplicationRecord
  belongs_to :project
  has_many :tasks, lambda { order(created_at: :DESC) }, dependent: :destroy

  validates :title,presence: true
  validates :deadline,presence: true
  validates :project_id,presence: true

  after_save :update_project

  def getCompletionRate
      total = tasks.size
      completed = tasks.where(completed:true).count

      return '100' if total==0;
      return '0' if completed==0;
      return "#{completed*100/total}"
  end

  def getCompleted
    return tasks.where(completed:true).count
  end

  def getTotal
    return tasks.size
  end

  def getTasks
    return tasks.order(expired: :desc ,flagged: :desc ,deadline: :asc)
  end

  def update_project
    project.update updated_at:DateTime.now()
  end

end
