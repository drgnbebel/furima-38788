require 'test_helper'

class FreesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get frees_index_url
    assert_response :success
  end

end
