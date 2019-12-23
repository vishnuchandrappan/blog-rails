require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = " | Rails Blog"
  end

  test "should get new" do
    get signup_url
    assert_response :success
    assert_select "title", "SignUp#{@base_title}"
  end

end
