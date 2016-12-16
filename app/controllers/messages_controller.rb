class MessagesController < ApplicationController

  before_action :authenticate_user

  def new
    @user = User.find(params[:id])
  end

  def create
    other_id = params[:id].to_i
    con = Conversation.findChat(current_user.id,other_id)
    if (con.nil?)
      con = Conversation.create(user1_id:current_user.id,user2_id:other_id)
    end
    conversation = con.id
    m = Message.create(sender_id:current_user.id,body:params[:body],conversation_id:conversation)
    m.updateConversation()
    redirect_to show_message_path(conversation)
  end

  def index
    conversations = Conversation.findAllChat(current_user.id)
    @users = [];
    @cons = [];
    conversations.each do |chat|
      user = chat.getOther(current_user)
      @users.push(user)
      @cons.push(chat)
    end
  end

  def show
    @user = Conversation.find(params[:id]).getOther(current_user)
    @messages = Message.where(conversation_id:params[:id])
  end

  def conversation
    m = Message.create(sender_id:current_user.id,body:params[:body],conversation_id:params[:id])
    m.updateConversation()
    redirect_to :back
  end
end
