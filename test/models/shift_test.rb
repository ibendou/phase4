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
      @assign_kathryn = FactoryBot.create(:assignment, employee: @kathryn, store: @oakland, start_date: 10.months.ago.to_date, end_date: nil, pay_level: 3)
    
      @past_shift = FactoryBot.create(:shift,assignment:@assign_kathryn)
      @past_shift.update_attribute(:date, Date.current-5)
      assert !@past_shift.completed?
      @past_shift.destroy
      @assign_kathryn.destroy
    end
    
    should "Check if start_now works" do
      @assign_kathryn = FactoryBot.create(:assignment, employee: @kathryn, store: @oakland, start_date: 10.months.ago.to_date, end_date: nil, pay_level: 3)
      @shift2 = FactoryBot.create(:shift, assignment:@assign_kathryn,  start_time: Date.current + 2.hours)
      @shift2.start_now
      assert_equal Time.now.hour, @shift2.start_time.hour
      @shift2.destroy
      @assign_kathryn.destroy
    end
    
    should "Check if end_now works" do
      @mopper = FactoryBot.create(:store, name:"Mopping floors")
      @cornell =   FactoryBot.create(:store, name:"Cornell")
      @bushra =  FactoryBot.create(:employee, first_name: "Bushra", last_name: "Bendou", role: "manager", date_of_birth: 30.years.ago.to_date)
      @assign_bushra = FactoryBot.create(:assignment, employee: @bushra, store: @cornell, start_date: 10.months.ago.to_date, end_date: nil, pay_level: 3)
      @shift3 = FactoryBot.create(:shift, assignment:@assign_bushra, start_time: Date.current + 3.hours)
      @shift3.end_now
      assert_equal Time.now.hour, @shift3.end_time.hour
      @shift3.destroy
      @assign_bushra.destroy
    end
   
    #should "return shifts of employee of a manager with assignments in the same stores" do
    #  assert_equal [], Shift.for_manager("3").map{|a| a.assignment.store.name}
    #end
   
  end
end 
