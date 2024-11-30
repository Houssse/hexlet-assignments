require "test_helper"

module Posts
  class PostCommentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @post = posts(:one)
      @post_comment = @post.post_comments.create(body: "Great post!")
    end

    test "should create post comment" do
      assert_difference('PostComment.count', 1) do
        post post_post_comments_url(@post), params: { post_comment: { body: "New comment" } }
      end
      assert_redirected_to @post
      assert_equal "Post comment was successfully created.", flash[:notice]
    end

    test "should get edit" do
      get edit_post_post_comment_url(@post, @post_comment)
      assert_response :success
    end

    test "should update post comment" do
      patch post_post_comment_url(@post, @post_comment), params: { post_comment: { body: "Updated comment" } }
      assert_redirected_to @post
      @post_comment.reload
      assert_equal "Updated comment", @post_comment.body
      assert_equal "Post comment was successfully updated.", flash[:notice]
    end

    test "should not update post comment with invalid data" do
      patch post_post_comment_url(@post, @post_comment), params: { post_comment: { body: "" } }
      assert_response :unprocessable_entity
    end

    test "should destroy post comment" do
      assert_difference('PostComment.count', -1) do
        delete post_post_comment_url(@post, @post_comment)
      end
      assert_redirected_to @post
      assert_equal "Post comment was successfully destroyed.", flash[:notice]
    end
  end
end