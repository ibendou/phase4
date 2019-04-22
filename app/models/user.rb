class User < ApplicationRecord
    has_secure_password

    belongs_to(:employee)
    validates_presence_of :email
    validates_presence_of :password_digest
    validates_presence_of :employee_id
    validates_uniqueness_of :email
    validates_presence_of :employee_id, on: :create
    validate :employee_is_active_in_system, on: :create
    
    validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "should have a valid email address", allow_blank: true

  
    private
    def employee_is_active_in_system
        all_active_employees = Employee.active.all.map{|e| e.id}
        unless all_active_employees.include?(self.employee_id)
         errors.add(:employee_id, "is not an active employee at the creamery")
        end
    end
    

    
    
end
