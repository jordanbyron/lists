class GiftsController < ApplicationController
  before_filter :find_gift
  
  def claim
    @gift.claim(current_user)
    
    redirect_to @gift.list
  end
  
  def return
    @gift.return_to_list(current_user)
    
    redirect_to @gift.list
  end
  
  def purchase
    claim = Claim.where(:user_id => current_user, :gift_id => @gift).first
    
    claim.update_attributes(:purchased => !claim.purchased) if claim
    
    redirect_to shopping_list_path
  end
  
  private
  
  def find_gift
    @gift = Gift.find(params[:id])
  end
end
