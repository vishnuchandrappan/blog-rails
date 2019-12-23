require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = " | Rails Blog"
  end

  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "home#{@base_title}"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "about#{@base_title}"
  end

end
