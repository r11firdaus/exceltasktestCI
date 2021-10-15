require 'rails_helper'

RSpec.describe Post, type: :model do
	describe "Associations" do
  	#it { should belong_to(:user).without_validating_presence }
		it { should belong_to(:user) }
	end
end
