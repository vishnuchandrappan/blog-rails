# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = ' | Rails Blog'
    @user = users(:vishnu)
    @other_user = users(:jithin)
  end

  test 'should get new' do
    get signup_url
    assert_response :success
    assert_template 'users/new'
    assert_select 'title', "SignUp#{@base_title}"
  end

  test 'should get edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    assert_response :success
    assert_select 'title', "edit#{@base_title}"
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        password: 'password',
        password_confirmation: 'password'
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch user_path(@user), params: {
      user: {
        name: @user.name
      }
    }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect users/index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

end
