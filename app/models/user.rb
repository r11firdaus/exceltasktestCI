class User < ApplicationRecord
	has_secure_password
	validates :username, presence: true
	validates :province, presence: true
	validates :city, presence: true
	validates :district, presence: true
	has_many :post, dependent: :destroy
end