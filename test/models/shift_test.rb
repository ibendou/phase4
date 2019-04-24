require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
    should belong_to(:shift_jobs)
    
    should validate_presence_of(:date)
    should validate_presence_of(:start_time)
    should validate_presence_of(:end_time)
    should validate_presence_of(:notes)
    
    should allow_value(7.weeks.ago.to_date).for(:date)
    should allow_value(2.years.ago.to_date).for(:date)
    should_not allow_value(1.week.from_now.to_date).for(:date)
    should_not allow_value("bad").for(:date)
    should_not allow_value(nil).for(:date)
    
    should_not allow_value(2.hours.from_now.to_time).for(:end_time)
    
    
    context "Creating a context for shifts" do
    setup do
     create_stores
     create_employees
     create_assignments
     create_shifts
    end

    teardown do
      #remove_shifts
      #remove_assignments
      #remove_employees
      #remove_stores
    end
    
    
    
  #  should "identify a past assignment as part of an invalid shift" do
  #    invalid_shift = FactoryBot.build(:shift, assignment: @assign_ben, date: 1.day.ago.to_date)
  #    assert_equal false,invalid_shift.valid?
  #  end
    
    should "return shifts for a given store" do
      assert_equal 3, Shift.for_store(3).size()
    end

    should "return shifts for a given employee" do
      assert_equal 1, Shift.for_employee(1).size()
    end
    
    should "return past shifts" do
      assert_equal 3, Shift.past().size()
    end
    
    should "return upcoming shifts" do
      assert_equal 0, Shift.upcoming().size()
    end
    
    should "return shifts for next x days" do
      assert_equal 0, Shift.for_next_days(10).size()
    end
    
    should "return shifts for past x days" do
      assert_equal 1, Shift.for_past_days(10).size()
    end
    
    should "return shifts by store" do
      assert_equal ["CMU","CMU","CMU"], Shift.by_store().map{|a| a.assignment.store.name}
    end
   
    should "return shifts by employee" do
      assert_equal ["Crawford, Cindy", "Gruberman, Ed", "Sisko, Ben"], Shift.by_employee().map{|a| a.assignment.employee.name}
    end
   
   
  end
end 
