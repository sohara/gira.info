require File.join(File.dirname(__FILE__), '/../../test_helper')

class MembreTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Membre.create!
  end
  
end