require 'test_helper'

class FlavorTest < ActiveSupport::TestCase
    should have_many(:store_flavors)
    should have_many(:stores).through(:store_flavors)
  
    should validate_presence_of(:name)
    
    context "Creating a context for flavors" do
      setup do
        create_flavors
      end

      teardown do
        remove_flavors
      end
  
      should "return active flavors" do
          assert_equal ["Lemon "], Flavor.active().map{|a| a.name}
      end
    
    
      should "return inactive flavors" do
          assert_equal ["Vanilla", "Chocolate"], Flavor.inactive().map{|a| a.name}
      end
    
    
      should "return flavors in alphabetical order" do
        assert_equal ["Chocolate", "Lemon ", "Vanilla"], Flavor.alphabetical().map{|a| a.name}
      end
      
      
      should "Show that flavors are never deleted, only made inactive" do
         @lemon.destroy
         assert_equal @lemon.active, false
      end
    end
end
