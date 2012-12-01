class AccountsController < ApplicationController
  before_filter :find_user
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your account was successfully updated"
      redirect_to account_path
    else
      render :show
    end
  end
  
  private
  
  def find_user
    @user           = current_user
    @authorizations = @user.authorizations
  end
  
end
