class Task < ApplicationRecord

  belongs_to :goal

  has_many :contributes, dependent: :destroy
  has_many :contributors, through: :contributes, source: :user

  validates :deadline,presence: true

  after_save :update_project
  def self.getTasks(id)
    Task.where(goal_id:id).order(flagged: :desc ,deadline: :asc)
  end
  def getClassType
    str= ""

    str += (completed ? 'completed' : "")
    str += " "
    str += (flagged ? 'flagged' : "")
    return str
  end

  def self.checkFlag(id)
    task = Task.find(id)
    today = Date.today
    if( !task.completed && !task.flagged)
      if((task.deadline - today) <=1)
        task.update flagged:true
        Log.createLogTask('autoflagged',task.goal.project.id,task)
        return true
      end
    end
    return false
  end

  def update_project
    goal.project.update updated_at:DateTime.now()
  end
end
