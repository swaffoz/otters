require 'test_helper'

class XmlrpcControllerTest < ActionController::TestCase
  test "should get xe_index" do
    get :xe_index
    assert_response :success
  end

end
