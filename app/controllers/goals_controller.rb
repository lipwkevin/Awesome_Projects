class GoalsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_admin
  def new
  end

  def create
    goal = Goal.new params.require(:goal).permit([:title,:deadline, :description,:project_id])
    if goal.save
      Log.createLogGoal('create',goal.project.id,goal,current_user)
      render partial: 'edit', locals:{goal:goal}
    else
      redirect_to(:back)
    end
  end

  def destroy
    goal = Goal.find params[:id]
    Log.createLogGoal('destroy',goal.project.id,goal,current_user)
    goal.destroy
    redirect_to(:back)
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update params.require(:goal).permit([:title,:deadline, :description ])
    Log.createLogGoal('update',@goal.project.id,@goal,current_user)
    redirect_to(edit_project_path(@goal.project))
  end

  def authorize_admin
    unless (user_signed_in? && is_admin(@goal.project_id,current_user))
      redirect_to project_path(@goal.project_id), alert: 'access denied, you are not an admin of this project!'
    end
  end
end
