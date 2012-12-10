class AccountsController < ApplicationController
  before_filter :find_user, :except => [:setup]
  
  def update
    if @user.update_attributes(params[:user])
      if @user.authorizations.empty?
        redirect_to new_identity_path
      else
        flash[:notice] = "Your account was successfully updated"
        redirect_to account_path
      end
    else
      render :show
    end
  end
  
  def setup
    @user = User.find_by_perishable_token(params[:key])
    if @user.blank? || !@user.authorizations.empty?
      flash[:error] = %{Sorry, this key is no longer valid or your account is 
                        already setup}
      redirect_to root_path
    else
      self.current_user = @user
      @user.save
    end
  end
  
  def shopping_list
    @gifts = GiftDecorator.decorate(@user.shopping_list)
  end
  
  private
  
  def find_user
    @user           = current_user
    @authorizations = @user.authorizations.where("provider != 'identity'")
  end
  
end
