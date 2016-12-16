class ProjectsController < ApplicationController
  before_action :find_project, except: [:index,:new,:create]
  before_action :authorize_access, except: [:index,:new,:create]
  before_action :authorize_admin, except: [:index,:new,:create,:show]
  before_action :authenticate_user, only: [:index,:new,:create]
  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if@project.save
      Leading.create(project:@project, user:current_user)
      Member.create(project:@project, user:current_user)
      Log.createLogProject('create',@project.id,@project,current_user)
      redirect_to edit_project_path(@project.id)
    else
      flash.now[:alert] = 'Please see errors below'
      render :new
    end
  end

  def update
    if @project.update project_params
      @project.update deadline:params[:project][:deadline].to_date
      flash[:notice] = 'Project updated'
      Log.createLogProject('update',@project.id,@project,current_user)
      redirect_to(:back)
    else
      flash.now[:alert] = 'Please see errors below!'
      render :edit
    end
  end

  def edit
  end

  def listMember
  end

  def editMember
    user = User.find(params[:user_id])
    admin = is_admin(@project.id,user)
    if admin
      admin.destroy
      Log.createLogMember('downgrade',@project.id,current_user,user)
    else
      Leading.create(project_id:@project.id,user_id:user.id)
      Log.createLogMember('promot',@project.id,current_user,user)
    end
    redirect_to :back
  end

  def removeMember
    user_id = params[:user_id]
    user = Member.find_by(user_id:user_id,project_id:@project.id)
    Log.createLogMember('remove',@project.id,current_user,User.find(user_id))
    user.destroy
    user = Leading.find_by(user_id:user_id,project_id:@project.id)
    if user
      user.destroy
    end
    redirect_to :back
  end

  def updateMember
    members = params[:user][:user_id]
    members.each do |member|
      unless Member.find_by(user_id:member,project:@project)
        if(member!='')
          Member.create(user_id:member,project:@project)
          Log.createLogMember('add',@project.id,current_user,User.find(member))
        end
      end
    end
    redirect_to :back
  end

  def index
    @projects = []
    if(user_signed_in?)
      @projects = current_user.join_project
    end
  end

  def show
    cookies[:timestamp] = DateTime.now();
  end

  def destroy
    @project.destroy
    redirect_to root_path, notice: 'Project deleted'
  end

  def check_update
    if @project.updated_at>cookies[:timestamp]
      flash.now[:alert] = 'Force Refresh '
      render json: {reload:true}
    else
      render json: {reload:false}
    end
  end

  def deleteAllGoal
    @project.goals.each do |goal|
      goal.destroy
    end
    Log.createLogProject('deleteAll',@project.id,@project,current_user)
    redirect_to project_path(@project)
  end
  private

  def authorize_access
    unless (user_signed_in? && @project.is_member(current_user))
      redirect_to root_path, alert: 'access denied, you have no access to this project!'
    end
  end

  def authorize_admin
    unless (user_signed_in? && is_admin(@project.id,current_user))
      redirect_to project_path(@project.id), alert: 'access denied, you are not an admin of this project!'
    end
  end
  def project_params
    params.require(:project).permit([:title, :description,:deadline,:status,id: []])
  end

  def find_project
    @project = Project.find params[:id]
  end


end
