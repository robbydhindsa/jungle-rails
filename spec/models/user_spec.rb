require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "validates the presence of first_name" do
      @user = User.new(
        :first_name => nil,
        :last_name => "Last",
        :email => "email@email.com",
        :password => "password",
        :password_confirmation => "password"
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include(
        "First name can't be blank"
      )
    end

    it "validates the presence of last_name" do
      @user = User.new(
        :first_name => "First",
        :last_name => nil,
        :email => "email@email.com",
        :password => "password",
        :password_confirmation => "password"
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include(
        "Last name can't be blank"
      )
    end

    it "validates the presence of email" do
      @user = User.new(
        :first_name => "First",
        :last_name => "Last",
        :email => nil,
        :password => "password",
        :password_confirmation => "password"
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include(
        "Email can't be blank"
      )
    end

    it "validates the password matching" do
      @user = User.new(
        :first_name => "First",
        :last_name => "Last",
        :email => "email@email.com",
        :password => "password",
        :password_confirmation => "password123"
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include(
        "Password confirmation doesn't match Password"
      )
    end

    it "validates password length of 3" do
      @user = User.new(
        :first_name => "First",
        :last_name => "Last",
        :email => "email@email.com",
        :password => "ab",
        :password_confirmation => "ab"
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include(
        "Password is too short (minimum is 3 characters)"
      )
    end

    it "validates emails are unique/NOT case sensitive" do
      @user = User.new(
        :first_name => "First",
        :last_name => "Last",
        :email => "email@email.com",
        :password => "123",
        :password_confirmation => "123"
      )
      @user.save

      @user2 = User.new(
        :first_name => "First2",
        :last_name => "Last2",
        :email => "EMAIL@EMAIL.COM",
        :password => "123",
        :password_confirmation => "123"
      )
      expect(@user2).not_to be_valid
      expect(@user2.errors.full_messages).to include(
        "Email has already been taken"
      )
    end

  end

  describe '.authenticate_with_credentials' do

    it "should authenticate with correct credentials" do
      @user = User.new(
        :first_name => "First",
        :last_name => "Last",
        :email => "email@email.com",
        :password => "123",
        :password_confirmation => "123"
      )
      @user.save
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it "should not authenticate with incorrect email" do
      @user = User.new(
        :first_name => "First",
        :last_name => "Last",
        :email => "email@email.com",
        :password => "123",
        :password_confirmation => "123"
      )
      @user.save
      expect(User.authenticate_with_credentials("fake@email.com", @user.password)).to be_nil
    end

    it "should authenticate with spaces around email" do
      @user = User.new(
        :first_name => "First",
        :last_name => "Last",
        :email => "email@email.com",
        :password => "123",
        :password_confirmation => "123"
      )
      @user.save
      expect(User.authenticate_with_credentials("   email@email.com  ", @user.password)).to eq(@user)
    end

  end

end
