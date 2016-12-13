class TasksController < ApplicationController
  before_action :requer_login
  def new
  end

  def create
    task = Task.new params.require(:task).permit([:title,:deadline, :completed,:flagged,:goal_id,user_ids:[]])
    byebug
    project_id = Goal.find(params[:goal_id]).project_id
    if task.save
      Log.createLogTask('create',project_id,task,current_user)
      render partial: 'edit', locals:{task:task}
    else
      render :new
    end
  end
  def destroy
    task = Task.find params[:id]
    Log.createLogTask('destroy',task.goal.project.id,task,current_user)
    task.destroy
    redirect_to(:back)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update params.require(:task).permit([:title,:deadline, :completed,:flagged])
    project_id = @task.goal.project_id
    Log.createLogTask('update',project_id,@task,current_user)
    redirect_to edit_project_path(@task.goal.project.id)
  end

  def setFlag
    task = Task.find(params[:id])
    task.flagged =  !task.flagged
    Log.createLogTask(((task.completed)? "flagged": "unflagged"),task.goal.project.id,task,current_user)
    task.save
    render :nothing => true, :status => 204
  end

  def setComplete
    task = Task.find(params[:id])
    task.completed =  !task.completed
    project_id = params[:id]
    Log.createLogTask(((task.completed)? "checked": "unchecked"),task.goal.project.id,task,current_user)
    task.save
    render :nothing => true, :status => 204
  end

  def relocateTask
    task = Task.find(params[:id])
    task.update params.permit([:goal_id])
  end
end
