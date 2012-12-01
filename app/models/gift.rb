class Gift < ActiveRecord::Base
  has_many   :claims
  belongs_to :list

  def self.available
    joins(%{LEFT JOIN (SELECT gifts.id, count(claims.id) as total_claims
            FROM gifts LEFT JOIN claims ON gifts.id = claims.gift_id
            GROUP BY gifts.id) AS c ON gifts.id = c.id}).
      where("gifts.quantity > c.total_claims")
  end
  
  def self.claimed_by(user)
    includes(:claims).where("claims.user_id = ?", user.id)
  end
  
  def self.not_claimed_by(user)
    includes(:claims).where("claims.user_id != ?", user.id)
  end
  
  def claim!(user)
    Claim.create(:user => user, :gift => self)
  end
  
  def return!(user)
    claims.find_by_user_id(user).destroy
  end
  
  def available?
    claims.count < quantity
  end
  
  def claimed_by?(user)
    claims.where(:user_id => user).any?
  end
  
end
