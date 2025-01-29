# frozen_string_literal: true

# BEGIN

# END

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    # BEGIN
    repository_url = params[:repository_url]

    begin
      octokit_repo = Octokit::Repository.from_url(repository_url)

      client = Octokit::Client.new
      repository_data = client.repository(octokit_repo)

      @repository = Repository.new(
        link: repository_data.html_url,
        owner_name: repository_data.owner.login,
        repo_name: repository_data.name,
        description: repository_data.description,
        default_branch: repository_data.default_branch,
        watchers_count: repository_data.watchers_count,
        language: repository_data.language,
        repo_created_at: repository_data.created_at,
        repo_updated_at: repository_data.updated_at
      )

      if @repository.save
        redirect_to @repository, notice: 'Repository successfully added!'
      else
        render :new, status: :unprocessable_entity
      end
    rescue Octokit::NotFound
      redirect_to repositories_url, alert: 'Repository not found.'
    rescue StandardError => e
      redirect_to repositories_url, alert: "Something went wrong: #{e.message}"
    end
    # END
  end

  def edit
    @repository = Repository.find params[:id]
  end

  def update
    @repository = Repository.find params[:id]

    if @repository.update(permitted_params)
      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end
