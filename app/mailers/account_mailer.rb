class AccountMailer < ActionMailer::Base
  default from: "Simple Gift List <donotreply@simplegiftlist.com>"

  def setup(user)
    @user = user

    mail(:to      => user.email,
         :subject => "Welcome to Simple Gift List!").deliver
  end

  def password_reset(user)
    @user = user

    mail(to: user.email,
         subject: "Password Reset for Simple Gift List")
  end
end
