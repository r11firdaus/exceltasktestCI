require 'rails_helper'

RSpec.describe Post, type: :model do
	let(:user) {
    User.new(username: 'usertes',
             password: '1234',
             district: 'CIMAHI UTARA',
             city: 'CIMAHI',
             province: 'JAWA BARAT')
  }

	describe "Associations" do
  	it { should belong_to(:user).without_validating_presence }
		#it { should belong_to(:user) }
	end
end
