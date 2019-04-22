class Shift < ApplicationRecord
    belongs_to(:assignment)
    has_many(:shift_jobs)
    
    validates_presence_of(:date)
    validates_presence_of(:start_time)
    validates_presence_of(:end_time)
    validates_presence_of(:notes)
    validate :should_only_be_added_to_current_assignments, on: :create
    validates_date :date, on_or_before: lambda { Date.current }, on_or_before_message: "cannot be in the future"
    validates_datetime :end_time, :after => :start_time
    
    scope :completed, ->{}
    scope :incompleted, ->{}
    scope :for_store,     ->(store_id) { where("store_id = ?", store_id) }
    scope :for_employee,  ->(employee_id) { where("employee_id = ?", employee_id) }
    scope :past, -> {where("date < ?", Date.current)}
    scope :upcoming, -> {where("date >= ?", Date.current)}
    scope :for_next_days, ->(x) {where("date >= ? and date <= ? ", Date.current, x.days.from_now)}
    scope :for_past_days, ->(x) {where("date <= ? and date >= ? ", Date.current, x.days.ago)}
    scope :by_store,      -> { joins(:store).order('name') }
    scope :by_employee,   -> { joins(:employee).order('last_name, first_name') }

    def completed?
        
    end
    
    def start_now
    end
    
    def end_now
    end

    private
    def should_only_be_added_to_current_assignments
        all_current_assignments = Assignment.current.all.map{|a| a.id}
        unless all_current_assignments.include?(self.assignment_id)
         errors.add(:assignment_id, "is not a current assignment")
        end
    end
    
end
