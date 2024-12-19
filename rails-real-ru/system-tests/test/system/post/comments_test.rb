require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "creating a comment" do
    visit post_path(@post)
    fill_in "Content", with: "This is a new comment"
    click_on "Add Comment"
    
    assert_text "Comment was successfully created"
    assert_text "This is a new comment"
  end

  test "viewing comments on a post" do
    visit post_path(@post)
    assert_text @comment.content
  end

  test "deleting a comment" do
    visit post_path(@post)
    accept_confirm do
      click_on "Delete Comment", match: :first
    end

    assert_text "Comment was successfully destroyed"
  end
end