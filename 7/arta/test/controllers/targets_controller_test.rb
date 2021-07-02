require 'test_helper'

class TargetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get targets_index_url
    assert_response :success
  end

end
