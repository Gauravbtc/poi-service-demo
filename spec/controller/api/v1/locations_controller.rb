require "rails_helper"

describe Api::V1::LocationsController, type: :controller do

  describe "Location index action" do
    let (:user) { FactoryBot.create(:user) }
    let (:auth_token) { Auth.encode({user: user.id}) }

    it "lists of Point of interests" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      FactoryBot.create(:location)
      get :index
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(true)
    end
  end

  describe "Location create action" do
    let (:user) { FactoryBot.create(:user) }
    let (:auth_token) { Auth.encode({user: user.id}) }

    it "should create Point of interest" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      post :create, params: {location: { address: "lala garden", user_id: user.id }}
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(true)
      expect(response.status).to eq(200)
    end

    it "should not create Point of interest when user_id blank" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      post :create, params: {location: { address: "lala garden" }}
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(false)
    end

    it "should not create Point of interest when auth_token blank" do
      post :create, params: {location: { address: "lala garden" }}
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(false)
    end
  end

  describe "Location update action" do
    let (:user) { FactoryBot.create(:user) }
    let (:auth_token) { Auth.encode({user: user.id}) }

    it "should update Point of interest" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      location = FactoryBot.create(:location)
      updated_location = FactoryBot.attributes_for(:location, address: "Doho park", user_id: user.id)
      put :update, params: {id: location, location: updated_location}
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(true)
      expect(response.status).to eq(200)
    end

    it "should not update Point of interest when user_id blank" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      location =  FactoryBot.create(:location)
      updated_location = FactoryBot.attributes_for(:location, address: "Doho park")
      put :update, params: {id: location, location: updated_location}
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(false)
    end

    it "should not update Point of interest when auth_token blank" do
      location = FactoryBot.create(:location)
      updated_location = FactoryBot.attributes_for(:location, address: "Doho park", user_id: user.id)
      put :update, params: {id: location, location: updated_location}
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(false)
    end
  end

  describe "Location show action" do
    let (:user) { FactoryBot.create(:user) }
    let (:auth_token) { Auth.encode({user: user.id}) }

    it "should display one location" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      location = FactoryBot.create(:location)
      get :show,params: {id: location.id }
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(true)
    end
  end

  describe "Location destroy action" do
    let (:user) { FactoryBot.create(:user) }
    let (:auth_token) { Auth.encode({user: user.id}) }

    it "should delete location" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      location = FactoryBot.create(:location)
      delete :destroy, params: {id: location.id }
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(true)
    end
  end

  describe "Location create route" do
    let (:user) { FactoryBot.create(:user) }
    let (:auth_token) { Auth.encode({user: user.id}) }
    it "should create point of interest map" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      start_location = FactoryBot.create(:location)
      end_location = FactoryBot.create(:location, address: "Lala garden")
      post :create_route, params: { "locations": [start_location.id.to_i, end_location.id.to_i] }
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(true)
    end

    it "should now create point of interest when only one location has been pass" do
      user.update(auth_token: auth_token)
      request.headers["HTTP_AUTH_TOKEN"] = user.auth_token
      start_location = FactoryBot.create(:location)
      post :create_route, params: { "locations": [start_location.id] }
      location = JSON.parse(response.body)
      expect(location["success"]).to eq(false)
    end
  end
end
