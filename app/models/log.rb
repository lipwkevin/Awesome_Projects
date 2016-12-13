class Log < ApplicationRecord
  belongs_to :user
  def getUser
    (user)? "#{user.name}" : 'System'
  end

  def self.createLogMember(event,id,user,user2)
    body=''
    case event
    when 'add'
      body = "#{user.name} added a member: #{user2.name}"
    when 'remove'
      body = "#{user.name} removed a member: #{user2.name}"
    when 'promot'
      body = "#{user.name} made #{user2.name} an admin"
    when 'downgrade'
      body = "#{user.name} made #{user2.name} an member"
    end
    Log.create(body:body,project_id:id)
  end

  def self.createLogTask(event,id,task,user=nil)
    body=''
    case event
    when 'create'
      body = "#{user.name} created a new task:

       title: #{task.title},
       deadline: #{task.deadline}"
    when 'destroy'
      body = "#{user.name} deleted a task: #{task.title}"
    when 'update'
      body = "#{user.name} updated a task:
       title: #{task.title},
       deadline: #{task.deadline}"
    when 'checked'
      body = "#{user.name} completed a task: #{task.title}"
    when 'unchecked'
      body = "#{user.name} unchecked a task: #{task.title}"
    when 'flagged'
      body = "#{user.name} flagged a task: #{task.title}"
    when 'unflagged'
      body = "#{user.name} un-flagged a task: #{task.title}"
    when 'autoflagged'
      body = "#{task.title} is flagged due to deadline"
    end
    Log.create(body:body,project_id:id)
  end

  def self.createLogGoal(event,id,goal,user)
    body=''
    case event
    when 'create'
      body = "#{user.name} created a new goal:

       title: #{goal.title},
       description: #{goal.description},
       deadline: #{goal.deadline}"
    when 'destroy'
      body = "#{user.name} deleted a goal: #{goal.title}"
    when 'update'
      body = "#{user.name} updated a goal:
       title: #{goal.title},
       description: #{goal.description},
       deadline: #{goal.deadline}"
    end
    Log.create(body:body,project_id:id)
  end

  def self.createLogProject(event,id,project,user)
    body='<p>'
    case event
    when 'create'
      body = "#{user.name} created a new project:

       title: #{project.title},
       description: #{project.description},
       status: #{project.status},
       deadline: #{project.deadline}"
    when 'deleteAll'
      body = "#{user.name} deleted all project goals"
    when 'update'
      body = "#{user.name} updated a project:
       title: #{project.title},
       description: #{project.description},
       status: #{project.status},
       deadline: #{project.deadline}"
    when 'share'
      body = "#{user.name} created a new sharable link:
              <a href=\"#{ENV['DOMAIN']}/token/#{project}\">#{ENV['DOMAIN']}/token/#{project}</a>"
    end
    Log.create(body:body,project_id:id)
  end
end
