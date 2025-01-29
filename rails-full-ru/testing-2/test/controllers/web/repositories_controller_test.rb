# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  # BEGIN
  setup do
    @repository_url = 'https://github.com/someuser/somerepo'
  end

  test 'should create repository' do
    stub_request(:get, @repository_url)
      .to_return(status: 200, body: load_fixture('files/response.json'), headers: { 'Content-Type' => 'application/json' })

    post repositories_url, params: { repository_url: @repository_url }

    repository = Repository.last
    assert_equal 'MyString', repository.link
    assert_equal 'MyText', repository.description
  end
  # END
end
