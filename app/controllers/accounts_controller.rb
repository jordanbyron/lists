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
    if params[:key].present?
      @user = User.find_by_perishable_token(params[:key])
      if @user.blank? || !@user.authorizations.empty?
        flash[:error] = %{Sorry, this key is no longer valid or your account is
                          already setup}
        redirect_to root_path
      else
        if current_user.present? && current_user != @user
          link_to_current_user
          redirect_to root_path
        else
          self.current_user = @user
          store_location
        end
      end
    else
      flash[:error] = %{We're sorry, but it looks like the link you are using
      is missing some information. Please ask the person who invited you to
      re-send you invitation}
      redirect_to root_path
    end
  end

  def shopping_list
    @gifts = GiftDecorator.decorate_collection(@user.shopping_list)
  end

  def link_to_existing_user
    self.current_user = nil
  end

  private

  def find_user
    @user           = current_user
    @authorizations = @user.authorizations.where("provider != 'identity'")
  end

  def link_to_current_user
    @user.invites.update_all(user_id: current_user.id)
    @user.destroy
  end
end
