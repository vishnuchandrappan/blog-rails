require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:vishnu)
  end

  test 'password resets' do
    get new_passsword_reset_path
    assert_template 'passsword_resets/new'
    post passsword_resets_path, params: {
      password_reset: {
        email: 'wrong@email$format'
      }
    }
    assert_not flash.empty?

    assert_template 'passsword_resets/new'
    post passsword_resets_path, params: {
      password_reset: {
        email: @user.email
      }
    }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url

    user = assigns(:user)
    get edit_passsword_reset_path(user.reset_token, email: '')
    assert_redirected_to root_url

    user.toggle!(:activated)
    get edit_passsword_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url

    get edit_passsword_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url

    get edit_passsword_reset_path(user.reset_token, email: user.email)
    # assert_template 'passsword_resets/edit'
    # assert_select 'input[name=email][type=hidden][value=?]', user.email

    patch passsword_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: 'foobar',
        password_confirmation: 'barfoo'
      }
    }
    # assert_select 'div#errors'

    patch passsword_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: '',
        password_confirmation: ''
      }
    }
    # assert_select 'div#errors'

    patch passsword_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: 'password',
        password_confirmation: 'password'
      }
    }
    assert_not flash.empty?
    assert_redirected_to root_path
    # assert is_logged_in?
  end

  test 'expired token' do
    get new_passsword_reset_path
    post passsword_resets_path, params: {
      password_reset: {
        email: @user.email
      }
    }
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch passsword_reset_path(@user.reset_token), params: {
      email: @user.email,
      user: {
        password: 'foobar',
        password_confirmation: 'foobar'
      }
    }
    assert_response :redirect
    follow_redirect!
    assert_match /expired/i, response.body
  end
end
