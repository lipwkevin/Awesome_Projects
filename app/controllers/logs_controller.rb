class LogsController < ApplicationController

  def create
    log = Log.new
    log.body =  params[:body]
    log.user = current_user
    log.project_id = params[:id]
    if log.save
      redirect_to(:back)
    else
      render :new
    end
  end

  def index
    @logs = Log.where(project_id:params[:id]).order(created_at: :desc).limit(10)
    @id = params[:id]
  end

  def show
    @logs = Log.where(project_id:params[:id]).order(created_at: :desc)
    @id = params[:id]
  end
end
