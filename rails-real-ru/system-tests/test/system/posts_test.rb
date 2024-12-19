# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "creating a post" do
    visit new_post_path
    fill_in "Title", with: "My new post"
    fill_in "Body", with: "This is the body of the post"
    click_on "Create Post"

    assert_text "Post was successfully created"
    assert_text "My new post"
  end

  test "viewing a post" do
    visit post_path(@post)
    assert_text @post.title
    assert_text @post.body
  end

  test "editing a post" do
    visit edit_post_path(@post)
    fill_in "Title", with: "Updated title"
    click_on "Update Post"

    assert_text "Post was successfully updated"
    assert_text "Updated title"
  end

  test "deleting a post" do
    visit posts_path
    accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
# END
