class AccountMailer < ActionMailer::Base
  def setup(user)
    @user = user
    
    mail(:to      => user.email,
         :from    => "Simple Gift List <donotreply@simplegiftlist.com>",
         :subject => "Gift List is now Simple Gift List!").deliver
  end
end
