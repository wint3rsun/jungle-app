require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should save successfully' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      expect(user).to be_valid
    end

    it 'should validate that a first name is present' do
      user = User.new(
        first_name: nil,
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      expect(user).to be_invalid
    end

    it 'should validate that a last name is present' do
      user = User.new(
        first_name: 'Jane',
        last_name: nil,
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      expect(user).to be_invalid
    end

    it 'should validate that a email is present' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: nil,
        password: 'testing',
        password_confirmation: 'testing'
      )
      expect(user).to be_invalid
    end

    it 'should validate that an email is unique' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      user2 = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      expect(user2).to be_invalid
    end

    it 'should validate that an email is unique not case-sensitive' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'TEST@TESTING.CA',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      user2 = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      expect(user2).to be_invalid
    end

    it 'should validate that a password is present' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: nil,
        password_confirmation: 'testing'
      )
      expect(user).to be_invalid
    end
    
    it 'should validate that a password confirmation is present' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: nil
      )
      expect(user).to be_invalid
    end

    it 'should not save if a password and password confirmation match' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing2'
      )
      expect(user.save).to be false
    end

    it 'should validate that password length is at least 8 characters' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'test',
        password_confirmation: 'test'
      )
      expect(user).to be_invalid
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should return an instance of user if successfully authenticated' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      authenticated = User.authenticate_with_credentials('test@testing.ca','testing')
      expect(authenticated).to eq(user)
    end

    it 'should successfully authenticate even if email has extra spaces' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      authenticated = User.authenticate_with_credentials(' test@testing.ca  ','testing')
      expect(authenticated).to eq(user)
    end

    it 'should successfully authenticate even if regardless of email case' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      authenticated = User.authenticate_with_credentials('test@TESTING.ca','testing')
      expect(authenticated).to eq(user)
    end

    it 'should return nil if not successfully authenticated - wrong password' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      authenticated = User.authenticate_with_credentials('test@testing.ca','testin')
      expect(authenticated).to eq(nil)
    end

    it 'should return nil if not successfully authenticated - wrong email' do
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'test@testing.ca',
        password: 'testing',
        password_confirmation: 'testing'
      )
      user.save

      authenticated = User.authenticate_with_credentials('est@testing.ca','testing')
      expect(authenticated).to eq(nil)
    end

  end
end
