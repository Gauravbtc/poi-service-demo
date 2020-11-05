require "rails_helper"

describe Api::V1::Users::RegistrationsController, type: :controller do

  describe "User Registation" do
    it "should create user" do
      post :create, params: {email: "gaurav@yopmail.com",password: "12345", password_confirmation: "12345" }
       ## updating zaiko
       byebug
      # updated_categories = JSON.parse(response.body)
      # expect(updated_categories["success"]).to eq(true)
      # expect(updated_categories["message"]).to eq("Zaiko Updated")
      # expect(updated_categories["status_code"]).to eq(200)
    end
  end
end
