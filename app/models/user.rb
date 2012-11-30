class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :lists,          :dependent => :destroy
  has_many :invites,        :dependent => :destroy

  attr_protected :admin

  def self.create_from_hash!(hash)
    attributes = {
      name:  hash['info']['name'],
      email: hash['info']['email']
    }

    if hash['provider'] == 'twitter'
      attributes[:twitter] = hash['info']['nickname']
    end

    create(attributes)
  end
  
  def invited_lists
    List.includes(:invites).where("invites.user_id = ?", id)
  end
end
