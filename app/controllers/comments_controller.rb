# frozen_string_literal: true

# only create and destroy function for comments, because its a child from post
class CommentsController < ApplicationController
  before_action :user_signed_in?

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.commenter = session[:userdata]['username']
    return unless @comment.save

    # respond_to do |format|
    #   format.js
    # end

    # using action cable with serializer
    serialized_comment =
      ActiveModelSerializers::SerializableResource.new(@comment,
                                                       { serializer: CommentSerializer }).as_json
 
    ActionCable.server.broadcast 'comment_channel', {
    	#content: @comment,
		content: serialized_comment, #using serializer
	    sender: session[:userdata]['username'],
	    type: 'create_comment'
    }
  end

  def destroy
    @comment = Comment.find(params[:id])
    return unless @comment.destroy

    ActionCable.server.broadcast 'comment_channel', {
      content: @comment,
      sender: session[:userdata]['username'],
      type: 'delete_comment'
    }
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
