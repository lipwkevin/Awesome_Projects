class Conversation < ApplicationRecord
  belongs_to :user1
  belongs_to :user2

  def getOther(user)
    other_id = -1;
    if(user1_id==user.id)
      other_id = user2_id;
    else
      other_id = user1_id
    end
    other = User.find(other_id);
    return other
  end

  def self.findChat(u1,u2)
    c = nil
    c = find_by(user1_id:u1,user2_id:u2)
    if c.nil?
      c = find_by(user1_id:u2,user2_id:u1)
    end
    return c
  end

  def self.findAllChat(user_id)
    where('user1_id=? or user2_id=?',user_id,user_id).order(updated_at: :desc)
  end
end
