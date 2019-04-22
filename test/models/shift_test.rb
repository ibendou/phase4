require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
    should belong_to(:assignment)
    should have_many (:shift_jobs)
    
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
      remove_shifts
      remove_assignments
      remove_employees
      remove_stores
    end
    
    
    
    should "identify a past store as part of an invalid shift" do
      puts @ed.first_name
      puts @oakland.name
      puts @assign_ed.employee.first_name
      puts @assign_ed.store.name
      shift = FactoryBot.build(:shift, assignment: @assign_ben, date: 1.day.ago.to_date)
      assert_equal false,shift.valid?
    end
    
    
    
  end
end 
