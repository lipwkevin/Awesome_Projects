class Task < ApplicationRecord

  belongs_to :goal

  has_many :contributes, dependent: :destroy
  has_many :contributors, through: :contributes, source: :user

  validates :title,presence: true
  validates :deadline,presence: true
  validates :goal_id,presence: true

  after_save :update_project
  def self.getTasks(id)
    Task.where(goal_id:id).order(flagged: :desc ,deadline: :asc)
  end
  def getClassType
    str= ""
    str += (completed ? 'completed ' : "")
    str += (flagged ? 'flagged ' : "")
    str += (expired&&!completed ? 'expired ' : "")
    return str
  end

  def checkFlag()
    today = Date.today
    if(!completed && !flagged)
      if((deadline - today) <=1)
        update flagged:true
        Log.createLogTask('autoflagged',goal.project.id,self)
      end
    end
    if(!expired)
      if(deadline.past?)
        update expired:true
        Log.createLogTask('expired',goal.project.id,self)
      end
    end
    return expired
  end

  def update_project
    goal.project.update updated_at:DateTime.now()
    goal.update updated_at:DateTime.now()
  end
end
