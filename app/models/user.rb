class User < ApplicationRecord
    
   
    has_secure_password
    

    belongs_to(:employee)
    validates_presence_of :email, :employee_id
    validates_uniqueness_of :email
    validates_presence_of :employee, on: :create
    validates_presence_of :password_digest, on: :create
    validate :check_employee_is_active, on: :create
    
    validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "should have a valid email address", allow_blank: true

  
    private
    def check_employee_is_active
        all_active_employees = Employee.active.all.map{|e| e.id}
        unless all_active_employees.include?(self.employee_id)
         errors.add(:employee_id, "is not an active employee at the creamery")
        end
    end

end
