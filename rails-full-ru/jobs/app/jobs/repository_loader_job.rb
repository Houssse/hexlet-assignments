# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)

    repository.fetch!

    response = fetch_github_data(repository.link)

    if response
      repository.update!(
        owner_name: response[:owner][:login],
        repo_name: response[:name],
        description: response[:description],
        default_branch: response[:default_branch],
        watchers_count: response[:watchers_count],
        language: response[:language],
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      )
      repository.succeed!
    else
      repository.fail!
    end
  rescue StandardError => e
    Rails.logger.error "Ошибка загрузки репозитория: #{e.message}"
    repository.fail!
  end

  private

  def fetch_github_data(link)
    owner, repo = parse_github_link(link)
    return nil unless owner && repo

    url = "https://api.github.com/repos/#{owner}/#{repo}"
    response = Faraday.get(url)

    return JSON.parse(response.body, symbolize_names: true) if response.success?

    nil
  end

  def parse_github_link(link)
    match = link.match(%r{https://github.com/(?<owner>[^/]+)/(?<repo>[^/]+)})
    match ? [match[:owner], match[:repo]] : [nil, nil]
  end
end
