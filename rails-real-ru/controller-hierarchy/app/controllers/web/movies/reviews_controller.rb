module Web
  module Movies
    class ReviewsController < ApplicationController
      before_action :set_review, only: %i[edit update destroy]

      def index
        @reviews = resource_movie.reviews
      end

      def new
        @review = resource_movie.reviews.build
      end

      def create
        @review = resource_movie.reviews.build(review_params)

        if @review.save
          redirect_to movie_reviews_path(resource_movie), notice: 'Review created successfully.'
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit; end

      def update
        @review = resource_movie.reviews.find(params[:id])

        if @review.update(review_params)
          redirect_to movie_reviews_path(resource_movie), notice: 'Review updated successfully.'
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @review = resource_movie.reviews.find(params[:id])
        @review.destroy
        redirect_to movie_reviews_path(resource_movie), notice: 'Review deleted successfully.'
      end

      private

      def set_review
        @review = resource_movie.reviews.find(params[:id])
      end

      def review_params
        params.require(:review).permit(:body)
      end
    end
  end
end
