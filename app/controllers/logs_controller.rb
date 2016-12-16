class LogsController < ApplicationController

  before_action :authorize_admin

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

  def authorize_admin
    unless (user_signed_in? && is_admin(params[:id],current_user))
      redirect_to root_path, alert: 'access denied, you are not an admin of this project!'
    end
  end
end
