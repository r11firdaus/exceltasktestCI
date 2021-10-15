require 'rails_helper'

RSpec.describe User, type: :model do
	subject {
		described_class.new(username: 'usertes',
											 password: '1234',
											 district: 'CIMAHI UTARA',
											 city: 'CIMAHI',
											 province: 'JAWA BARAT')
	}
	
	it 'is valid with attributes' do
		expect(subject).to be_valid
	end

	it 'is not valid without a username' do
		subject.username = nil
		expect(subject).to_not be_valid
	end

	it 'id not valid without a password' do
		subject.password = nil
		expect(subject).to_not be_valid
	end

	it 'is not valid without a district' do
		subject.district = nil
		expect(subject).to_not be_valid
	end

	it 'is not valid without a city' do
		subject.city = nil
		expect(subject).to_not be_valid
	end

	it 'is not valid without a province' do
		subject.province = nil
		expect(subject).to_not be_valid
	end
end
