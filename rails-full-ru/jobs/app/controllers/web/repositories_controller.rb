# frozen_string_literal: true

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
    repository = Repository.new(permitted_params)

    if repository.save
      RepositoryLoaderJob.perform_now(repository.id)
      redirect_to repositories_path, notice: 'Репозиторий добавлен и загружается'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    repository = Repository.find(params[:id])
    RepositoryLoaderJob.perform_now(repository.id)

    redirect_to repositories_path, notice: 'Загрузка обновленных данных запущена'
  end

  def update_repos
    Repository.order(:updated_at).each do |repository|
      RepositoryLoaderJob.perform_now(repository.id)
    end

    redirect_to repositories_path, notice: 'Обновление всех репозиториев запущено'
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
