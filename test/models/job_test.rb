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
          assert_equal 2, Job.active().size()
      end
    
    
      should "return inactive jobs" do
          assert_equal 1, Job.inactive().size()
      end
    
    
      should "return jobs in alphabetical order" do
        assert_equal ["Cleaning machines", "Mixing products", "Selling Icecream "], Job.alphabetical().map{|a| a.name}
      end


    should "Show that job can only be deleted if the job has never been worked by an employee; otherwise it is made inactive" do
         @texas = FactoryBot.create(:store, name:"texas")
         @imane = FactoryBot.create(:employee, first_name: "imane", last_name: "bendou", role: "manager", phone: "412-268-2323")
         @imane_ass = FactoryBot.create(:assignment, employee: @imane, store: @texas, start_date: 6.months.ago.to_date, end_date: nil, pay_level: 4)
         @shift_imane = FactoryBot.create(:shift, assignment:@imane_ass)
         @shift_job_cash = FactoryBot.create(:shift_job, job_id:  @mixer.id)

         @mixer.destroy
       
         assert_equal 1, Job.inactive.size
         assert_equal ["Mixing products"], Job.inactive.map{|i| i.name}.sort
      
         @shift_job_cash.destroy
         @shift_imane.destroy
         @imane_ass.destroy
         @imane.destroy
         @texas.destroy
    end

    end
    
end
