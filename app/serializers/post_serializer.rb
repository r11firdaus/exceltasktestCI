# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :role_id, :title, :image_url, :body, :created_at
  #attributes :id, :title, :image_url, :body, :created_at

  #belongs_to :user, serializer: WriterSerializer 
  has_many :comments, serializer: CommentSerializer
end
