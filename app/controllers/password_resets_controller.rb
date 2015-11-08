class PasswordResetsController < ApplicationController
  def new

  end

  def create
    @user = User.where(email: params[:email]).first

    if @user && @user.authorizations.where(provider: 'identity').any?
      @user.reset_perishable_token
      @user.save
      AccountMailer.password_reset(@user).deliver_now
      flash[:notice] = "An email with instructions have been sent to #{@user.email}"
      redirect_to root_path
    else
      flash[:error] = "Sorry, we can't find an account with that email"
      render :new
    end
  end

  def edit
    @user = User.where(perishable_token: params[:id]).first

    unless @user
      flash[:error] = "Sorry, that link is no longer valid. Please try to reset your password again"
      redirect_to(new_password_reset_path) && return
    end

    @identity = @user.authorizations.where(provider: 'identity').first.identity
  end

  def update
    @user = User.where(perishable_token: params[:id]).first
    @identity = @user.authorizations.where(provider: 'identity').first.identity

    @identity.password = params[:identity][:password]
    @identity.password_confirmation = params[:identity][:password_confirmation]

    if @identity.save
      flash[:notice] = "Password successfully reset"
      self.current_user = @user
      redirect_to root_path
    else
      render :edit
    end
  end
end
