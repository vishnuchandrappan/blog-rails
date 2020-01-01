require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:vishnu)
    @base_title = " | Rails Blog"
  end

  test "profile" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "title", "#{@user.name}#{@base_title}"
    assert_select 'img.gravatar'
    assert_select 'div.pagination'
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.title, response.body
    end
  end

end
