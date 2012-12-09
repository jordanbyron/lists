class List < ActiveRecord::Base
  belongs_to :user

  has_many :gifts,   :dependent => :destroy
  has_many :invites, :dependent => :destroy

  validates_presence_of :name
  
  accepts_nested_attributes_for :gifts,  
    :allow_destroy => true, 
    :reject_if     => lambda { |gift| gift[:name].blank? }
  
  accepts_nested_attributes_for :invites, 
    :allow_destroy => true, 
    :reject_if     => lambda { |invite| invite[:email].blank? }

  def self.active
    where("occurs_on >= ?", Date.today)
  end
end
