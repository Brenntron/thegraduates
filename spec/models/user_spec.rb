require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniquesness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_least(3) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_least(3) }
    it { should validate_presence_of(:bio) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password).on(:create) }
    it { should_not validate_presence_of(:password).on(:update) }
    it { should validate_presence_of(:password_confirmation).on(:create) }
    it { should_not validate_presence_of(:password_confirmation).on(:update) }
    it "should allow valid values for email" do
      should all_value("brennan@brennanwilligham.com", "a@b.co.uk", "brennan+hash@example.com").for(:email)
    end
    describe "should not save if email is !unique" do
      it "should have an error message 'email already in use'" do
        Fabricate(:user, email: "brennan@willingham.com")
        user = Fabricate.build(:user, email: "brennan@willingham.com")
        user.valid?.should be_falsey
        (user.errors[:email].any?).should be_truthy
        error = user.errors[:email][0]
        expect(error).to eq('email already in use')
      end
    end
    describe "should be invalid if email is not formatted correctly" do
      it { should_not allow_value("brennanwillingham.com").for(:email) }
      it { should_not allow_value("brennan@examplecom").for(:email) }
      it { should_not allow_value("@.com").for(:email) }
    end
    it "should have a working factory" do
      Fabricate.build(:user).should be_valid
    end
  end
end
