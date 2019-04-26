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
    
     should "should not allow password_digest to be null" do
      @paul = FactoryBot.build(:employee, first_name: "Paul", active: false)
      upaul = FactoryBot.build(:user, employee: @paul, email: "amar@gmail.com", password_digest:nil)
      assert_equal false, upaul.valid?
    end
    

  end

end
