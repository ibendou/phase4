class Job < ApplicationRecord

  has_many(:shift_jobs)

  # make sure required fields are present
  validates_presence_of :name
    
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  
  def destroy
    if (ShiftJob.where("job_id=?",id).size() !=0) then
      active = true
    end
  end 
end
