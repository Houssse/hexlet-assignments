module Posts
  class PostCommentsController < ApplicationController
    before_action :set_post, only: [:create, :edit, :update, :destroy]
    before_action :set_post_comment, only: [:edit, :update, :destroy]

    # POST /posts/:post_id/post_comments
    def create
      @post_comment = @post.post_comments.new(post_comment_params)

      if @post_comment.save
        redirect_to @post, notice: "Post comment was successfully created."
      else
        render 'posts/show', status: :unprocessable_entity
      end
    end

    # GET /posts/:post_id/post_comments/:id/edit
    def edit
    end

    # PATCH/PUT /posts/:post_id/post_comments/:id
    def update
      if @post_comment.update(post_comment_params)
        redirect_to @post, notice: "Post comment was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /posts/:post_id/post_comments/:id
    def destroy
      @post_comment.destroy
      redirect_to @post, notice: "Post comment was successfully destroyed."
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_post_comment
      @post_comment = @post.post_comments.find(params[:id])
    end

    def post_comment_params
      params.require(:post_comment).permit(:body)
    end
  end
end
