class Flavor < ApplicationRecord
    
  has_many :store_flavors
  has_many :stores, through: :store_flavors

  # make sure required fields are present
  validates_presence_of :name
    
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  #override destroy method. Never delete. Make inactive instead
  def destroy
    self.active = false
  end
  
    
end
