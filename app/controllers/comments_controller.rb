# frozen_string_literal: true

# only create and destroy function for comments, because its a child from post
class CommentsController < ApplicationController
  before_action :user_signed_in?

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.commenter = session[:userdata]['username']
    return unless @comment.save

    respond_to do |format|
      format.js
    end
    # ActionCable.server.broadcast "comment_channel", {content: @comment, sender: session[:userdata]["username"]}
    # end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to(post_path(@post))
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
