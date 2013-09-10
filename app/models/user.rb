class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :openstax_uid, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def is_administrator?
    self.is_administrator
  end

  def is_anonymous?
    false
  end

  def name
    "#{first_name} #{last_name}"
  end
  
end
