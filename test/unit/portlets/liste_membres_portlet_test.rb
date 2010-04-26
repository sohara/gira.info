require File.join(File.dirname(__FILE__), '/../../test_helper')

class ListeMembresTest < ActiveSupport::TestCase

  test "Should be able to create new instance of a portlet" do
    assert ListeMembresPortlet.create!(:name => "New Portlet")
  end
  
end