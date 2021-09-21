# frozen_string_literal: true

# comment models by post
class Comment < ApplicationRecord
  belongs_to :post
  validates :commenter, presence: true, length: { minimum: 1 }
  validates :body, presence: true, length: { minimum: 1 }
end
