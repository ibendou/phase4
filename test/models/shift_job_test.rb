require 'test_helper'

class ShiftJobTest < ActiveSupport::TestCase

  should belong_to(:job)
  should belong_to(:shift)
  
end
