class User < ApplicationRecord
  has_secure_password

  has_many :contributes, dependent: :destroy
  has_many :contributing, through: :contributes, source: :task

  has_many :leadings, dependent: :destroy
  has_many :leading_task, through: :leadings, source: :project

  has_many :members, dependent: :destroy
  has_many :join_project, through: :members, source: :project

  def name
    return "#{first_name} #{last_name}"
  end
end
