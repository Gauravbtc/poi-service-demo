require 'rails_helper'
RSpec.describe User, type: :model do
  describe "creation" do
    let (:user) { FactoryBot.create(:user) }

    it "can be created" do
      expect(user).to be_valid
    end

    it "can not be created without email and password " do
      user.email = nil
      expect(user).to be_invalid
    end
  end

  describe "validations" do
    let (:user) { FactoryBot.create(:user) }

    it "require email" do
      user.email = nil
      expect(user.save).to be_falsy
    end

    it "email must be unique" do
      user = FactoryBot.create(:user)
      new_user = FactoryBot.build(:user,email: user.email)
      expect(new_user.valid?).to be_falsy
    end
  end
end
