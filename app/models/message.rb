class Message < ApplicationRecord
  belongs_to :conversation, touch:true

  def isSender(user)
    return (sender_id==user.id.to_s)
  end

  def getCssClass(user)
    return (isSender(user))? 'sent' : 'recieve'
  end

  def getSenderName
    user = User.find(sender_id)
    return user.name
  end

  def getTime
    return created_at.strftime('%d %b %Y %H:%M:%S')
  end

  def updateConversation
    conversation.update updated_at:DateTime.now
  end
end
