class GiftsController < ApplicationController
  before_filter :find_gift
  
  def claim
    @gift.claim!(current_user)
    
    redirect_to @gift.list
  end
  
  def return
    @gift.return!(current_user)
    
    redirect_to @gift.list
  end
  
  private
  
  def find_gift
    @gift = Gift.find(params[:id])
  end
end
