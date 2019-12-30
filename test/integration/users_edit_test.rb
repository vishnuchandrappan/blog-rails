require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:vishnu)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: {
        name: "",
        password: "foo",
        password_confirmation: "bar"
      }
    }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "John Doe"
    patch user_path(@user), params: {
      user: {
        name: name,
        password: "password",
        password_confirmation: "password"
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
  end

end
