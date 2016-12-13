class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email].downcase
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Welcome'
    else
      flash.now[:alert] = 'Fail to log in'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    # equivalent to deleting the user_id key from session
    redirect_to root_path, notice: 'Goodbye'
  end
end
