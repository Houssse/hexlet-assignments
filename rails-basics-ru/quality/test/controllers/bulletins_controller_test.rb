# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
    assert_select 'h1', 'Bulletins'
    assert_select 'li', @bulletin.title
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin.id)
    assert_response :success
    assert_select 'h1', @bulletin.title
  end
end
