class GiftDecorator < ApplicationDecorator
  decorates :gift

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
      h.link_to "Return", h.return_gift_path(gift), :method => 'post'
    
    # Otherwise, if the gift is still available, let them claim it
    #
    elsif gift.available?
      h.link_to "Claim", h.claim_gift_path(gift), :method => 'post'
    end
  end
  
  def link
    h.link_to "LINK", gift.link unless gift.link.blank?
  end
end

