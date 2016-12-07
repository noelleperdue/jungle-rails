require 'rails_helper'

RSpec.describe User, type: :model do

  context "Validations" do

    it "has all valid properties " do
      @user = User.create(firstname:"Noelle", lastname: "Perdue", email: "perdue.noelle@gmail.com",
                          password:"elleon", password_confirmation: "elleon")
      @user.validate!
      @user.errors.full_messages
    end

    it "must have a firstname" do
      @user = User.create(firstname: nil, lastname: "Perdue", email: "perdue.noelle@gmail.com",
                          password:"elleon", password_confirmation: "elleon")

         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("please enter first name")
    end

    it "must have last name" do
      @user = User.create(firstname:"Noelle", lastname: nil, email: "perdue.noelle@gmail.com",
                          password:"elleon", password_confirmation: "elleon")

         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Please enter last name")
    end

     it "must have a email" do
        @user = User.create(firstname:"Noelle", lastname: "Perdue", email: nil,
                          password:"elleon", password_confirmation: "elleon")
         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("please fill in email field")
     end

      it "must have unique email" do

        @user1 = User.create(firstname:"Noelle", lastname: "Perdue", email: "perdue.noelle@gmail.com",
                          password:"elleon", password_confirmation: "elleon")
        @user2 = User.create(firstname:"Steven", lastname: "Conway", email: "perdue.noelle@gmail.com",
                          password:"elleon", password_confirmation: "elleon")

        expect(@user2.errors.messages[:email]).to eq ["We already have a registered user with that email"]
      end

      it "must have a password" do

         @user = User.create(firstname:"Noelle", lastname: "Perdue", email: "perdue.noelle@gmail.com",
                          password: nil, password_confirmation: "elleon")

         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Password can't be blank")
      end

     it "must have a password confirmation" do

         @user = User.create(firstname:"Noelle", lastname: "Perdue", email:"perdue.noelle@gmail.com" ,
                          password:"elleon", password_confirmation: nil)

         expect(@user).to_not be_valid
         expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
  end
  describe '.authenticate_with_credentials' do


    it "must have email to sign in" do
      @user_register = User.create(firstname:"Noelle", lastname: "Perdue", email:"perdue.noelle@gmail.com" ,
                          password:"elleon", password_confirmation: "elleon")

      @user_signin = User.authenticate_with_credentials("perdue.noelle@gmail.com","elleon")

      expect(@user_register).to eq(@user_signin)
    end
  end
end
