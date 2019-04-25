require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # Test relationships
  should belong_to(:employee)
  
  # Test basic validations
  should validate_presence_of(:email)
  should validate_presence_of(:password_digest)
  should validate_uniqueness_of(:email)
  should have_secure_password
  
  should allow_value("imanebendou@gmail.com").for(:email)
  should allow_value("ibendou@gmail.com").for(:email)
  should allow_value("ibendou@andrew.cmu.edu").for(:email)
  should_not allow_value(nil).for(:email)
  should_not allow_value("Imane Bendou").for(:email)
  should_not allow_value("ibendou").for(:email)
  
  
  context "Creating a context for users" do
    # create the objects I want with factories
    setup do 
      create_users
    end
    
    # and provide a teardown method as well
    teardown do
      remove_users
    end
    
    should "identify a non-active employee as part of an invalid user" do
      @fred = FactoryBot.build(:employee, first_name: "Fred", active: false)
      inactive_employee = FactoryBot.build(:user, employee: @fred, email: "fred@gmail.com")
      assert_equal false, inactive_employee.valid?
    end
    
  end

end
