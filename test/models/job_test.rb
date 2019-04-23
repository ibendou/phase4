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
    end
end
