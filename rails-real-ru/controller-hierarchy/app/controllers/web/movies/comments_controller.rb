module Web
  module Movies
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[edit update destroy]

      def index
        @comments = resource_movie.comments
      end

      def new
        @comment = resource_movie.comments.build
      end

      def create
        @comment = resource_movie.comments.build(comment_params)

        if @comment.save
          redirect_to movie_comments_path(resource_movie), notice: 'Comment created successfully.'
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit; end

      def update
        @comment = resource_movie.comments.find(params[:id])

        if @comment.update(comment_params)
          redirect_to movie_comments_path(resource_movie), notice: 'Comment updated successfully.'
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @comment = resource_movie.comments.find(params[:id])
        @comment.destroy
        redirect_to movie_comments_path(resource_movie), notice: 'Comment deleted successfully.'
      end

      private

      def set_comment
        @comment = resource_movie.comments.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
