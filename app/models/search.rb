# frozen_string_literal: true

# advanced search models
class Search < ApplicationRecord
  paginates_per 10
  self.inheritance_column = 'not_sti'

  def search_post
    post = Post.all

    post = post.where(['title ILIKE ?', "%#{title}%"]) if title.present?
    post = post.order("created_at #{body}") if body.present?

    post
  end
end
