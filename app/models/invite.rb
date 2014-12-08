class Invite < ActiveRecord::Base
  before_create :find_or_create_user
  after_create  :notify_user

  belongs_to :user
  belongs_to :list

  validates_presence_of :email

  attr_writer :name

  def email=(email)
    @email   = email.downcase
    @name  ||= @email
  end

  def email
    user.try(:email) || @email
  end

  def name
    user.try(:name) || @name
  end

  private

  def find_or_create_user
    self.user = User.find_or_create_by_email(:email => email, :name => name)
  end

  def notify_user
    InviteMailer.new_invite(self).deliver
  end
end
