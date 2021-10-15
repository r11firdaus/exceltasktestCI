# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  # attributes :id, :username, :role_id, :posts
  attributes :id

  def posts
    object.post
  end
end
