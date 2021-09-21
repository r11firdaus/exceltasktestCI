# frozen_string_literal: true

# post models posted by registered user only
class Post < ApplicationRecord
  paginates_per 10
  has_many :comments, dependent: :destroy # kalau post di delete, comment juga di delete
  validates :title, presence: true, length: { minimum: 1 }
  validates :body, presence: true, length: { minimum: 1 }
  belongs_to :user

  self.inheritance_column = 'not_sti'

  def self.search(search)
    if search
      where(['title ILIKE ?', "%#{search}%"])
    else
      all
    end
  end

  # belum beres, besok bikin tambah create post + image di upload excel
  # validates :imageurl, presence: true
end
