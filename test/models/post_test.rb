require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:vishnu)
    @post = @user.posts.new(
      title: "foobar",
      body: "lorem ipsum"
    )
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "title should be present" do
    @post.title = nil
    assert_not @post.valid?
  end

  test "body should be present" do
    @post.body = nil
    assert_not @post.valid?
  end

  test "title should not exceed 140 charecters" do
    @post.title = " "*141
    assert_not @post.valid?
  end

  test "body should not exceed 255 charecters" do
    @post.body = " "*257
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

end
