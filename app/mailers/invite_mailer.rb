class InviteMailer < ActionMailer::Base
  
  def new_invite(invite)
    @invite = invite
    @list   = ListDecorator.decorate(invite.list)
    
    mail(:to      => invite.user.email,
         :from    => "#{@list.user.name} <TODO-EMAIL>",
         :subject => "You've been invited to view #{@list.name}").deliver
  end
end
