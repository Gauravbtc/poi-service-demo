require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "creation" do
    let (:location) { FactoryBot.create(:location) }

    it "can be created" do
      expect(location).to be_valid
    end

    it "can not be created without user" do
      location.user_id = nil
      expect(location.save).to be_falsy
    end
  end

  describe "validations" do
    let (:location) { FactoryBot.create(:location) }

    it "require address" do
      location.address = nil
      expect(location.save).to be_falsy
    end

    it "can not be created without user" do
      location.user_id = nil
      expect(location.save).to be_falsy
    end
  end
end
