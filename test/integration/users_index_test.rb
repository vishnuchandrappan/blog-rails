require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:vishnu)
    @non_admin = users(:jithin)
  end

  test "index with pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: user.name
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
