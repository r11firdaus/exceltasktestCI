require 'rails_helper'

RSpec.describe Post, type: :model do
	let(:user) {
    User.new(username: 'testuser',
						 password: '1234',
						 province: 'JAWA BARAT',
						 city: 'CIMAHI',
						 district: 'CIMAHI UTARA')
  }

	describe "Associations" do
  	#it { should belong_to(:user).without_validating_presence }
		it { should belong_to(:user) }
	end
end
