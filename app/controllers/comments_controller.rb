# frozen_string_literal: true

# only create and destroy function for comments, because its a child from post
class CommentsController < ApplicationController
  before_action :user_signed_in?

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.commenter = session[:username]
    if @comment.save
      # render js: js_to_create_comment(@comment)
      # ActionCable.server.broadcast "comment_channel", {content: @comment, sender: session[:username]}
    end
  end

  # def js_to_create_comment(comment)
  #   "$('#comment').append(`
  #       <div class='card bg-light my-2'>
  #         <div class='card-body'>
  #           <strong class='card-title'>#{comment.commenter}</strong>
  #           <p>#{comment.body}</p>
  #           <a href='/posts/#{comment.post_id}/comments/#{comment.id}' data-confirm='Are you sure' data-method='delete'>Delete Comment</a>
  #         </div>
  #       </div>
  #    `)
  #    $('#comment_body').val('')"
  # end

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
