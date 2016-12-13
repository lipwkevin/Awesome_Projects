class TokensController < ApplicationController

  def create
    Token.create(
      event:params[:event],
      target:params[:id],
      token:SecureRandom.hex(8)
    )
  end

  def show
    obj = Token.find_by(token: params[:hex])
    case obj.event
    when 'share'
      project = Project.find(obj.target)
      render :share , locals:{project:project}
    when 'forget'
      render :forget_password
    else
      render :error
    end
  end

  def createShare
    t = Token.create(
      event:"share",
      target:params[:id],
      token:SecureRandom.hex(8)
    )
    Log.createLogProject('share',params[:id],t.token,current_user)
    render 'complete', locals:{hex:t}
  end
end
