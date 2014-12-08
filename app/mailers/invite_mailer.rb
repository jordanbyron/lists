class InviteMailer < ActionMailer::Base
  def new_invite(invite)
    @invite = invite
    @list   = ListDecorator.decorate(invite.list)

    @user = @invite.user
    @user.reset_perishable_token
    @user.save

    mail(:to      => invite.user.email,
         :from    => "#{@list.user.name} <donotreply@simplegiftlist.com>",
         :subject => "You've been invited to view #{@list.name}")
  end
end
