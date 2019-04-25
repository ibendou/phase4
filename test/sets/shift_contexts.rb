module Contexts
  module ShiftContexts
    # Context for Shifts (assumes contexts for stores, employees, assignments)
    def create_shifts
      @shift_ed = FactoryBot.create(:shift, assignment: @assign_ed, date: 1.year.ago.to_date) # ended a month ago
      @shift_ben = FactoryBot.create(:shift, assignment: @assign_ben, date: 1.year.ago.to_date)
      @shift_cindy = FactoryBot.create(:shift, assignment: @assign_cindy)
    end
    
    def remove_shifts
      @shift_ed.destroy
      @shift_ben.destroy
      @shift_cindy.destroy
    end

    

  end
end