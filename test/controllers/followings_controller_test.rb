require 'test_helper'

class FollowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get followings_create_url
    assert_response :success
  end

end
