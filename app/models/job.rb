class Job < ApplicationRecord

  has_many(:shift_jobs)

  # make sure required fields are present
  validates_presence_of :name
    
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :for_employee,  ->(employee_id) { where("employee_id = ?", employee_id) }
  
  #override destroy method. Make inactive of job used in a shift
  def destroy
    if (ShiftJob.where("job_id=?",self.id).size() ==0) then
      super
    else
      self.active = false
    end
  end 
end
