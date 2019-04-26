require 'test_helper'

class JobTest < ActiveSupport::TestCase
    should have_many (:shift_jobs)
    should validate_presence_of(:name)
    
    context "Creating a context for jobs" do
      setup do
        create_jobs
      end

      teardown do
        remove_jobs
      end
  
      should "return active jobs" do
          assert_equal ["Cleaning machines", "Selling Icecream "], Job.active().map{|a| a.name}
      end
    
    
      should "return inactive jobs" do
          assert_equal ["Mixing products"], Job.inactive().map{|a| a.name}
      end
    
    
      should "return jobs in alphabetical order" do
        assert_equal ["Cleaning machines", "Mixing products", "Selling Icecream "], Job.alphabetical().map{|a| a.name}
      end


    should "Show that job can only be deleted if the job has never been worked by an employee; otherwise it is made inactive" do
         
         #creating a job that is worked by an employee
         @texas = FactoryBot.create(:store, name:"texas")
         @imane = FactoryBot.create(:employee, first_name: "imane", last_name: "bendou", role: "manager", phone: "412-268-2323")
         @imane_ass = FactoryBot.create(:assignment, employee: @imane, store: @texas, start_date: 6.months.ago.to_date, end_date: nil, pay_level: 4)
         @shift_imane = FactoryBot.create(:shift, assignment:@imane_ass)
         @mopper = FactoryBot.create(:job, name:"Floor Mopper")
         @shift_job_cash = FactoryBot.create(:shift_job, job: @mopper)

         @mopper.destroy
         
         #mopper is not destroyed but made inactive instead     
         assert_equal false, @mopper.active
         
         @shift_job_cash.destroy
         
         #We destroy the shift then try to destroy the job again. Now the job is deleted because it is nore used in a shift
         @mopper.destroy
         assert_equal Job.where("id=?",@mopper.id).size(), 0
         
         
         
         @shift_imane.destroy
         @imane_ass.destroy
         @imane.destroy
         @texas.destroy
        
    end

    end
    
end
