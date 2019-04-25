class ShiftJob < ApplicationRecord
    belongs_to :shift 
    belongs_to :job
    
    scope :for_employee,  ->(employee_id) { where("shift_id in (?)", Shift.for_employee(employee_id)).select("shift_id") }
    scope :for_manager,  ->(manager_id) { where("shift_id in (?)", Shift.for_manager(manager_id)).select("shift_id") }

end
