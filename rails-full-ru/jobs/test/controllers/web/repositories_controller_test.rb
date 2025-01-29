# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hexlet_cv_repo = repositories :created
    @hexlet_sicp_repo = repositories :fetched

    @attrs = {
      link: 'https://github.com/hexlet/hexlet-friends'
    }
  end

  test 'get index' do
    get repositories_url
    assert_response :success
  end

  test 'get new' do
    get new_repository_url
    assert_response :success
  end

  test 'create' do
    uri_template = Addressable::Template.new 'https://api.github.com/repos/{owner_name}/{repo_name}'
    stub_request(:get, uri_template)
      .to_return(
        status: 200,
        body: load_fixture('files/hexlet-friends.json'),
        headers: { 'Content-Type' => 'application/json' }
      )

    post repositories_url, params: { repository: @attrs }

    repository = Repository.find_by @attrs

    assert { repository.fetched? }
    assert { repository.owner_name == 'hexlet' }
    assert { repository.repo_name == 'hexlet-friends' }
    assert { repository.description == 'This is fetched description' }
  end

  test 'update' do
    uri_template = Addressable::Template.new 'https://api.github.com/repos/{owner_name}/{repo_name}'
    stub_request(:get, uri_template)
      .to_return(
        status: 200,
        body: load_fixture('files/hexlet-cv.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
    patch repository_url(@hexlet_cv_repo)

    @hexlet_cv_repo.reload

    assert { @hexlet_cv_repo.fetched? }
    assert { @hexlet_cv_repo.owner_name == 'hexlet' }
    assert { @hexlet_cv_repo.repo_name == 'hexlet-cv' }
    assert { @hexlet_cv_repo.description == 'This is fetched description' }
  end

  test 'destroy' do
    delete repository_url(@hexlet_cv_repo)

    assert_redirected_to repositories_url
    refute { Repository.exists? @hexlet_cv_repo.id }
  end

  test 'update_repos' do
    stub_request(:get, 'https://api.github.com/repos/hexlet/hexlet-cv')
      .to_return(
        status: 200,
        body: load_fixture('files/hexlet-cv.json'),
        headers: { 'Content-Type' => 'application/json' }
      )

    stub_request(:get, 'https://api.github.com/repos/hexlet/hexlet-sicp')
      .to_return(
        status: 200,
        body: load_fixture('files/hexlet-sicp.json'),
        headers: { 'Content-Type' => 'application/json' }
      )

    patch update_repos_repositories_url

    @hexlet_cv_repo.reload
    assert { @hexlet_cv_repo.fetched? }
    assert { @hexlet_cv_repo.owner_name == 'hexlet' }
    assert { @hexlet_cv_repo.repo_name == 'hexlet-cv' }
    assert { @hexlet_cv_repo.description == 'This is fetched description' }

    @hexlet_sicp_repo.reload
    assert { @hexlet_sicp_repo.fetched? }
    assert { @hexlet_sicp_repo.owner_name == 'hexlet' }
    assert { @hexlet_sicp_repo.repo_name == 'hexlet-sicp' }
    assert { @hexlet_sicp_repo.description == 'This is fetched description' }
  end
end
