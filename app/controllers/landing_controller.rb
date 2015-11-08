class LandingController < ApplicationController
  def index
    redirect_to lists_path if current_user
  end
end
