class SessionsController < ApplicationController
  def create
    unless auth = Authorization.find_from_hash(auth_hash)
      auth = Authorization.create_from_hash(auth_hash, current_user)
    end

    self.current_user = auth.user

    redirect_back_or_default root_path
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

  def failure
    flash[:error] = "There was a problem logging in. Please try again"

    self.current_user = nil # Try destroying the current_user

    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
