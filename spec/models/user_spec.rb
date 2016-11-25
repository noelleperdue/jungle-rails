require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Validations' do

  it "is valid with all properties" do
    @user = User.create(name: 'Amy', email: 'amypound23@gmail.com' , password: 'cupcake1', password_confirmation: 'cupcake1')
    @user.validate!
    @user.errors.full_messages
  end

  it "is not valid with different passwords" do
    @user = User.create(name: 'Butters', email: 'butters@carrots.com', password: 'cupcake1', password_confirmation: 'cupcake2')
    expect(@user).to_not be_valid
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

    it "is not valid with no name" do
      @user = User.create(name: nil, email: 'butters@carrots.com', password: 'cupcake1', password_confirmation: 'cupcake1')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "is not valid with no email" do
      @user = User.create(name: "Butters", email: nil, password: 'cupcake1', password_confirmation: 'cupcake1')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "is not valid if password is too short" do
      @user = User.create(name: "Butters", email: 'butters@carrots.com', password: 'cups', password_confirmation: 'cups')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "is not valid if email is not unique" do
      @user = User.create(name: "Butters", email: 'butters@carrots.com', password: 'cupcake1', password_confirmation: 'cupcake1')
      @user2 = User.create(name: "Butters", email: 'buTTers@caRRots.com', password: 'cupcake1', password_confirmation: 'cupcake1')
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    context '.authenticate_with_credentials' do

    it "is valid if user has space before email" do
      @user = User.create(name: "Butters", email: '  butters@carrots.com', password: 'cupcake1', password_confirmation: 'cupcake1')
      @user.validate!
    end
  end
  end
end
