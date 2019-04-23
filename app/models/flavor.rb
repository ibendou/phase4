class Flavor < ApplicationRecord
    
  has_many :store_flavors
  has_many :stores, through: :store_flavors

  # make sure required fields are present
  validates_presence_of :name
    
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  before_destroy :cancel_destroy
  after_rollback :make_inactive


  private
  def cancel_destroy
  	return false
  end
  
  def make_inactive
  	self.active = 0
  	self.save
  end
    
end
