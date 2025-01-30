# frozen_string_literal: true

class Web::ArticlesController < Web::ApplicationController
  # BEGIN
  # END

  def index
    @articles = Article.all
  end

  # BEGIN
  def show
    @article = Rails.cache.fetch(['article', params[:id]], expires_in: 12.hours) do
      Article.find(params[:id])
    end
  end
  # END
end
