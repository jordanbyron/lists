class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    decorate_current_user
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
    decorate_current_user
  end

  def user_required
    unless signed_in?
      flash[:error] = "Please sign in to continue!"
      store_location
      redirect_to root_path
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def decorate_current_user
    @current_user = UserDecorator.decorate(@current_user) if @current_user
  end
end
