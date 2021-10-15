# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :post_id, :body, :commenter
end
