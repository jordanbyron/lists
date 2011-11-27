class List < ActiveRecord::Base
  belongs_to :user

  has_many   :gifts, :dependent => :destroy

  validates_presence_of :name

  def self.active
    where(:archived => false)
  end
end
