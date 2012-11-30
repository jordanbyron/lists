class List < ActiveRecord::Base
  belongs_to :user

  has_many   :gifts, :dependent => :destroy

  validates_presence_of :name
  
  accepts_nested_attributes_for :gifts,  
    :allow_destroy => true, 
    :reject_if     => lambda { |gift| gift['name'].blank? }

  def self.active
    where(:archived => false)
  end
end
