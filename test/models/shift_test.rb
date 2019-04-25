require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
    should have_many(:shift_jobs)
    should have_many(:jobs).through(:shift_jobs)
    should belong_to(:assignment)
    should have_one(:store).through(:assignment)
    should have_one(:employee).through(:assignment)
    
    should validate_presence_of(:date)
    should validate_presence_of(:start_time)
    should validate_presence_of(:assignment_id)
    
    
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
      remove_shifts
      remove_assignments
      remove_employees
      remove_stores
    end
    
    

    
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
   
   should "Check if completed? works" do
      @_shift = FactoryBot.create(:shift)
      @_shift.update_attribute(:date, Date.current-5)
      assert !@_shift.completed?
      @_shift.destroy
    end
    
    should "Check if start_now works" do
      @another_shift = FactoryGirl.create(:shift, start_time: Date.current + 2.hours)
      @another_shift.start_now
      assert_in_delta 1, Time.now.to_i, @another_shift.start_time.to_i
      @another_shift.destroy
    end
   
    should "return shifts of employee of a manager with assignments in the same stores" do
      assert_equal [], Shift.for_manager("3").map{|a| a.assignment.store.name}
    end
   
  end
end 
