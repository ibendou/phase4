class Shift < ApplicationRecord
    
    
    before_destroy :can_be_destroyed?
    after_create :default_end_time
    
    #Relationships
    has_many :shift_jobs
    has_many :jobs, through: :shift_jobs
    belongs_to :assignment
    has_one :store, through: :assignment
    has_one :employee, through: :assignment
    
    validates_presence_of(:date)
    validates_presence_of(:assignment_id)
    validates_presence_of(:start_time)
    validate :assignment_is_active_in_system, on: :create
    validates_date :date, on_or_before: lambda { Date.current }, on_or_before_message: "cannot be in the future"
    validates_datetime :end_time, :after => :start_time
    
    scope :completed,     -> { joins(:shift_jobs) }
    scope :incompleted,   -> { joins("LEFT JOIN shift_jobs ON shift_id")}
    scope :for_store,     ->(store_id) {joins(:assignment). where("store_id = ?", store_id) }
    scope :for_employee,  ->(employee_id) { joins(:assignment).where("employee_id = ?", employee_id) }
    scope :past, -> {where("date < ?", Date.current)}
    scope :upcoming, -> {where("date >= ?", Date.current)}
    scope :for_next_days, ->(x) {where("date >= ? and date <= ? ", Date.current, x.days.from_now)}
    scope :chronological, -> { order('date ASC') }
    scope :for_past_days, ->(x) {where("date <= ? and date >= ? ", Date.current, x.days.ago)}
    scope :by_store,      -> { joins(assignment: :store).order('name') }
    scope :by_employee,   -> { joins(assignment: :employee).order('last_name, first_name') }

    scope :for_manager,  ->(manager_id) { joins(:assignment).where("store_id in (?)", Assignment.all.select("store_id").where("employee_id = ? ",manager_id)) }

    def completed?
        self.shift_jobs.to_a.size != 0
    end
    
    def start_now
        self.update_attribute(:start_time, Time.now)
    end
    
    def end_now
        self.update_attribute(:end_time, Time.now)
    end

     private
    def assignment_is_active_in_system
  	    all_active_assignments = Assignment.current.map{|i| i.id}
        unless all_active_assignments.include?(self.assignment_id)
            errors.add(:assignment_id, "is not an active assignment at the creamery")
        end
    end

    def can_be_destroyed?
        return false unless self.date >= Date.current
    end

    def default_end_time
        self.end_time ||= self.start_time + 3.hours
        self.save
    end
    
end
