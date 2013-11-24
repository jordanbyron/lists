class User < ActiveRecord::Base
  before_save :reset_perishable_token

  has_many :authorizations, :dependent => :destroy
  has_many :lists,          :dependent => :destroy
  has_many :invites,        :dependent => :destroy

  has_many :claims,         :dependent => :destroy

  attr_protected :admin

  def self.create_from_hash!(hash)
    create(
      name:  hash['info']['name'],
      email: hash['info']['email']
    )
  end

  def invited_lists
    List.includes(:invites).where("invites.user_id = ?", id)
  end

  def shopping_list
    Gift.claimed_by(self).active.upcoming_and_recent.
      order("claims.purchased, lists.name, gifts.name")
  end

  def reset_perishable_token
    self.perishable_token = SecureRandom.hex(12)
  end
end
