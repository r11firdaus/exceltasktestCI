class Post < ApplicationRecord
	paginates_per 10
	has_many :comments, dependent: :destroy #kalau post di delete, comment juga di delete
	validates :title, presence: true, length: { minimum: 1 }
	validates :body, presence: true, length: { minimum: 1 }

	# belum beres, besok bikin tambah create post + image di upload excel
	# validates :imageurl, presence: true
end