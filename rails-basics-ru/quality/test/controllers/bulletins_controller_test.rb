# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one) # Убедитесь, что в fixtures есть `bulletins.yml`
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
    assert_select 'h1', 'Bulletins' # Предполагается, что есть заголовок на странице
    assert_select 'li', @bulletin.title # Проверьте отображение данных из fixtures
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin.id)
    assert_response :success
    assert_select 'h1', @bulletin.title # Убедитесь, что заголовок совпадает
  end
end
