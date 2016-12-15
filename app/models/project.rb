class Project < ApplicationRecord
  # has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :goals, lambda { order(created_at: :DESC) }, dependent: :destroy
  has_many :logs, lambda { order(created_at: :DESC) }, dependent: :destroy

  has_many :members, dependent: :destroy
  has_many :contributors, through: :members, source: :user

  has_many :leadings, dependent: :destroy
  has_many :leaders, through: :leadings, source: :user


  validates :title,presence: true
  validates :deadline,presence: true
  validates :status,presence: true

  def getTimeLeft
    today = Date.today
    remain = (deadline.mjd - today.mjd)
    return ((remain<0)? 'Expired' : "#{remain} Days")
  end

  def getTimeClass
    today = Date.today
    remain = (deadline.mjd - today.mjd)
    return ((remain<0)? 'Expired' : "")
  end

  def is_member(user)
    return contributors.find(user).present?
  end

  def checkUser(user)
    return (leaders.find_by(id:user.id).nil?)? 'Member' : 'Admin'
  end

  def updateTime
    return updated_at.strftime('%d %b %Y %H:%M')
  end
end
