class GiftDecorator < ApplicationDecorator
  decorates :gift
  decorates_association :list

  def price
    h.number_to_currency gift.price
  end
  
  def claimed_by
    gift.claims.map do |c|
      c.user.name unless c.user == h.current_user 
    end.compact.join(", ")
  end
  
  def claim_button
    
    # If a user has claimed this gift, let them return it
    #
    if gift.claimed_by? h.current_user
      h.link_to "Return", h.return_gift_path(gift), :method => 'post',
        :class => "return"
    
    # Otherwise, if the gift is still available, let them claim it
    #
    elsif gift.available?
      h.link_to "Claim", h.claim_gift_path(gift), :method => 'post', 
        :class => "claim"
    end
  end
  
  def purchase_button(user)
    claim = claim_for(user)
    
    if claim.purchased
      h.link_to "Purchased", h.purchase_gift_path(gift), :method => 'delete', 
        :class => "purchased"
    else
      h.link_to "Purchase", h.purchase_gift_path(gift), :method => 'post', 
        :class => "purchase"
    end
  end
  
  def name
    if gift.link.blank?
      gift.name
    else
      h.link_to gift.name, gift.link
    end
  end
  
  def css_class(user)
    css_classes = []
    
    # Check if the gift was claimed and purchased
    #
    claim = claim_for(user)
    
    if claim
      css_classes << 'claimed'
      css_classes << 'purchased' if claim.purchased
    end
    
    css_classes.join(' ')
  end
  
  private
  
  def claim_for(user)
     Claim.where(:user_id => user, :gift_id => gift).first
  end
end

