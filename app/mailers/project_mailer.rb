class ProjectMailer < ApplicationMailer

  def new_member_to_project(user,project)
    @user = user
    @project = project
    mail(to: @user.email, subject: "You have been addded to a project!")
  end


  def task_expired(task)
  end

  def project_expired(project)
  end

  def promote_to_admin(user,project)
  end

  def new_message(message)
  end
  
end
