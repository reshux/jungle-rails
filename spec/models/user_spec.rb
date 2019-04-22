require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject {
    described_class.new(
      first_name: "Test",
      last_name: "Test",
      email: "testingout@test.com",
      password: "testpass",
      password_confirmation: "testpass"
    )
  }

  describe 'Validations:' do  

    it 'should save a valid user' do
      subject.valid?
      expect(subject.errors.full_messages).to be_empty
    end

    it 'should not save without valid first name' do
      subject.first_name = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not save without valid last name' do
      subject.last_name = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not save with a short password' do
      subject.password = "12345"
      subject.valid?
      expect(subject.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'should not save without valid password' do
      subject.password = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save without valid password confirmation' do
      subject.password_confirmation = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not save without matching password and confirmation' do
      subject.password_confirmation = "horseysauce"
      subject.valid?
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it 'should not save with a duplicate email' do
      seconduser = User.new(
      first_name: "Test2",
      last_name: "Test2",
      email: "testingout@test.com",
      password: "testpass",
      password_confirmation: "testpass")
      subject.save
      seconduser.valid?
      expect(seconduser.errors.full_messages).to include ("Email has already been taken")
    end

    it 'should not save without a valid email' do
      subject.email = "123%"
      subject.save
      expect(subject.errors.full_messages).to include ("Email is invalid")
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should authenticate with correct credentials' do
      subject.save
      authenticate = User.authenticate_with_credentials("testingout@test.com", "testpass")
      expect(authenticate).to_not be_nil
    end

    it 'should not authenticate with false email' do
      subject.save
      authenticate = User.authenticate_with_credentials("bumbumbum@test.com", "testpass")
      expect(authenticate).to be_nil
    end

    it 'should not authenticate with false password' do
      subject.save
      authenticate = User.authenticate_with_credentials("testingout@test.com", "bumbumbum")
      expect(authenticate).to be_nil
    end
  end
end
