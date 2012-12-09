class UserDecorator < ApplicationDecorator
  decorates :user

  def shopping_list_link    
    return if user.shopping_list.empty?
      
    gifts = user.shopping_list.includes(:claims).
      where("claims.purchased = false").count
    
    description = "Shopping List"
    description += " (#{gifts})" unless gifts.zero?
    
    h.link_to description, h.shopping_list_path
  end
end